resource "null_resource" "run_script" {
  triggers = {
    ref = module.api_gateway.deployment_id
  }
  
 provisioner "local-exec" {
    command = <<-EOF
curl "${module.api_gateway.url}/${module.route_key1.path}"
EOF
  }
}