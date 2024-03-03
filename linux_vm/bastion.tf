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

/*
Verify that your instance's security group and VPC allow HTTPS (port 443) outbound traffic to the following Systems Manager endpoints:
ssm.ap-northeast-1.amazonaws.com
ec2messages.ap-northeast-1.amazonaws.com
ssmmessages.ap-northeast-1.amazonaws.com
module "sg4bastion" {
  source = "./sg"
  ingress_port = 80
  vpc_id = module.vpc.id
  cidrs = ["0.0.0.0/0"]
}
*/
/*
resource "aws_network_interface" "example" {
  subnet_id   = module.subnet4bastion.id
  private_ips = ["172.16.10.100"]
}

resource "aws_network_interface_attachment" "test" {
  instance_id          = aws_instance.bastion.id
  network_interface_id = aws_network_interface.example.id
  device_index         = 0
}
*/
resource "aws_eip" "example" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.example.id
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = "t2.small"
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  subnet_id              = module.subnet4bastion.id
  #vpc_security_group_ids = [module.sg4bastion.id]
}

# instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
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