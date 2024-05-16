
resource "aws_s3_bucket" "target" {
  bucket = "dst-${uuid()}"
}

module "source" {
  source = "./source"
}

module "build" {
  source = "./build"
  spec = var.build_spec
  image = var.build_image
}

