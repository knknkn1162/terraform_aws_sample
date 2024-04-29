

resource "null_resource" "run_script" {
  triggers = {
    ref = module.deployment.id
  }
  
 provisioner "local-exec" {
    command = <<-EOF
curl "${module.deployment.url}${module.deployment.stage}${module.path1.path}"
EOF
  }
}