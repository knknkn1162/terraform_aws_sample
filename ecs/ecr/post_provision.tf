locals {
  registry_name = "${aws_ecr_repository.example.registry_id}.dkr.ecr.${module.userinfo.region}.amazonaws.com"
  tag = "sample1234"
}

module "userinfo" {
  source = "../userinfo"
}

resource "null_resource" "run_script" {
  triggers = {
    ref = aws_ecr_repository.example.id
  }
  provisioner "local-exec" {
    command = <<-EOF
docker build --platform=linux/amd64 -t ${local.tag} ${path.module}/
aws ecr get-login-password | docker login --username AWS --password-stdin ${local.registry_name}
docker tag ${local.tag} ${aws_ecr_repository.example.repository_url}
docker push ${aws_ecr_repository.example.repository_url}
EOF
  }
}