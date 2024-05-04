
variable "domain" {
  type = string
}

variable "trigger" {
  type = string
}


resource "null_resource" "run_script" {
  triggers = {
    ref = var.trigger
  }
  
 provisioner "local-exec" {
    command = <<-EOF
${path.module}/script.sh ${var.domain}
EOF
  }
}