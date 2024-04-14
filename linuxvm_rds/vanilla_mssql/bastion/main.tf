variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}
variable "user_data" {
  type = string
  default = ":"
}

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
  user_data = var.user_data
}

# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
data "aws_iam_policy" "ssmManagedPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

module "iam_role4bastion" {
  source = "../iam_role"
  identifier = "ec2.amazonaws.com"
  policy = data.aws_iam_policy.ssmManagedPolicy.policy
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "instance-profile-${uuid()}"
  role = module.iam_role4bastion.name
}

output "user_data" {
  value = aws_instance.bastion.user_data
}