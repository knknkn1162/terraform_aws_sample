data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "subnet4bastion" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidrs = var.bastion_cidrs
}

module "sg4bastion" {
  source = "./sg"
  ingress_port = 22
  vpc_id = module.vpc.id
  cidrs = ["0.0.0.0/0"]
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = "t2.small"
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  subnet_id              = module.subnet4bastion.id
  vpc_security_group_ids = [module.sg4bastion.id]
}

data "aws_iam_policy" "ssmManagedPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

module "iam_role4bastion" {
  source = "./iam_role"
  identifier = "ec2.amazonaws.com"
  policy = data.aws_iam_policy.ssmManagedPolicy.policy
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "instance-profile-${uuid()}"
  role = module.iam_role4bastion.name
}