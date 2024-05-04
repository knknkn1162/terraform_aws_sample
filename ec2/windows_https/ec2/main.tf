variable "subnet_id" {}
variable "vm_spec" {}
variable "ami" {}

variable "domain" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "user_data" {
  type = string
}

module "key" {
  source = "./key"
}


resource "aws_instance" "example" {
  ami                    = module.ami4vm.id
  instance_type          = var.vm_spec
  subnet_id              = var.subnet_id
  # get_password_date is valid only Windows
  key_name = module.key.key
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  vpc_security_group_ids = var.sg_ids
  associate_public_ip_address = true
  
  user_data = <<-EOF
<powershell>
${var.user_data}
echo $null >> signal.log
</powershell>
<persist>true</persist>
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