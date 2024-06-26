variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}

variable "sg_ids" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type = bool
  default = false
}

variable "source_dest_check" {
  type = bool
  default = true
}

variable "allow_policy_arns" {
  type = list(string)
  default = []
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
  associate_public_ip_address = var.associate_public_ip_address
  key_name = module.key.key
  # Controls if traffic is routed to the instance when the destination address does not match the instance
  source_dest_check = var.source_dest_check
}

# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
module "role4ec2" {
  source = "./role4service"
  services = ["ec2.amazonaws.com"]
  allow_policy_arns = var.allow_policy_arns
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "instance-profile-${uuid()}"
  role = module.role4ec2.name
}

output "ssh_privkey" {
  value = module.key.pem
}

output "nic_id" {
  value = aws_instance.example.primary_network_interface_id
}