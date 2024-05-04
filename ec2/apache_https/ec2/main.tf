variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}

variable "domain" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

locals {
  username = "ec2-user"
  pem_dir = "/usr/local/ssl"
  ssl_conf_path = "/etc/httpd/conf.d/ssl.conf"
}

module "key" {
  source = "./key"
}

resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.vm_spec
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  associate_public_ip_address = true
  key_name = module.key.key
  provisioner "file" {
    source      = "${path.module}/assets/"
    destination = "/tmp/"
    connection {
      type = "ssh"
      user = local.username
      private_key = module.key.pem
      host     = self.public_ip
    }
  }
  user_data = <<-EOF
#!/bin/bash
sudo yum update
sudo yum -y install httpd mod_ssl
sudo systemctl enable httpd.service
sudo mkdir -p ${local.pem_dir}
sudo mv /tmp/certs/*.pem ${local.pem_dir}
cat /tmp/conf/ssl.conf.template | SSL_DOMAIN=${var.domain} PEM_DIR=${local.pem_dir} envsubst > ${local.ssl_conf_path}
sudo systemctl start httpd.service
EOF
}

# for test
data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
}


# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
module "role4ec2" {
  source = "./role4service"
  services = ["ec2.amazonaws.com"]
  allow_policy_arns = [
    data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
  ]
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "instance-profile-${uuid()}"
  role = module.role4ec2.name
}