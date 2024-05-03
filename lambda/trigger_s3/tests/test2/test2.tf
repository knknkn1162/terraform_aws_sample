variable "triggers" {
}

variable "s3_name" {
  type = string
}

variable "filename" {
  type = string
}

resource "null_resource" "run_script" {
  triggers = var.triggers
  
  provisioner "local-exec" {
    command = <<-EOF
echo "ok" | aws s3 cp - s3://${var.s3_name}/${var.filename}
EOF
  }
}