
resource "aws_s3_bucket" "artifact" {
  bucket = "artifact-${uuid()}"
  force_destroy = var.enable_debug
}

module "source" {
  source = "./source"
  force_destroy = var.enable_debug
}

resource "null_resource" "upload_source_s3" {
  triggers = {
    ref = module.source.id
  }
  
  provisioner "local-exec" {
    command = <<-EOF
zip -j ${var.source_s3_key} ${path.module}/scripts/*
aws s3 cp ${var.source_s3_key} s3://${module.source.name}/${var.source_s3_key}
EOF
  }
}

module "build" {
  source = "./build"
  spec = var.build_spec
  image = var.build_image
}

module "deploy" {
  source = "./deploy"
  force_destroy = var.enable_debug
}