locals {
  registry_name = "${aws_ecr_repository.example.registry_id}.dkr.ecr.${module.userinfo.region}.amazonaws.com"
}

module "userinfo" {
  source = "./userinfo"
}

resource "null_resource" "run_script" {
  triggers = {
    ref = aws_ecr_repository.example.id
  }
  provisioner "local-exec" {
    command = <<-EOF
aws ecr get-login-password | docker login --username AWS --password-stdin ${local.registry_name}
docker tag ${var.original_repo} ${aws_ecr_repository.example.repository_url}
docker push ${aws_ecr_repository.example.repository_url}
EOF
  }
}