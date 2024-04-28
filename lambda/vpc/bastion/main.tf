variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}

# we don't have to use aws_eip_association because it's already associated with vm
resource "aws_eip" "example" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}

resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.vm_spec
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  subnet_id              = var.subnet_id
}

# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
data "aws_iam_policy" "ssmManagedPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

module "iam_role" {
  source = "../iam_role"
  services = ["ec2.amazonaws.com"]
  managed_policy_arns = [
    data.aws_iam_policy.ssmManagedPolicy.arn
  ]
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "instance-profile-${uuid()}"
  role = module.iam_role.name
}