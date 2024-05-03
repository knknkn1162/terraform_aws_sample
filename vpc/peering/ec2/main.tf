variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}

variable "sg_ids" {
  type = list(string)
}

# we don't have to use aws_eip_association because it's already associated with vm
resource "aws_eip" "example" {
  instance = aws_instance.example.id
  domain   = "vpc"
}

resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.vm_spec
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_ids
}

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