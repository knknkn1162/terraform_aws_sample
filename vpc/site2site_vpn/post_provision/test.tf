
variable "ec2_id" {
  type = string
}

resource "null_resource" "run_script" {
  triggers = {
    ref = var.ec2_id
  }
  
 provisioner "local-exec" {
    command = <<-EOF
${path.module}/script.sh
EOF
  }
}