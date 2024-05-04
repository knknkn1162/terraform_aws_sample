variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}

variable "sg_ids" {
  type = list(string)
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
}

# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
module "role4ec2" {
  source = "./role4service"
  services = ["ec2.amazonaws.com"]
  allow_policy_arns = []
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "instance-profile-${uuid()}"
  role = module.role4ec2.name
}

output "ssh_privkey" {
  value = module.key.pem
}