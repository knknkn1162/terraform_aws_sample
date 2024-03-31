variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
  type = string
}

variable "vm_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

module "ami4vm" {
  source = "../ami/amzn_linux_2023"
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example" {
  public_key = tls_private_key.pk.public_key_openssh
}

resource "aws_instance" "vm" {
  ami                    = module.ami4vm.id
  instance_type          = var.vm_spec
  subnet_id              = var.vm_subnet_id
  # get_password_date is valid only Windows
  key_name = aws_key_pair.example.key_name
}

output "ssh_command" {
  value = "ssh -i key.pem ec2-user@${aws_instance.vm.private_ip}"
}

output "vm_user" {
  # see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-to-linux-instance.html
  value = "ec2-user"
}

output "ssh_privkey" {
  value = tls_private_key.pk.private_key_pem
}

output "private_ip" {
  value = aws_instance.vm.private_ip
}