module "ami4vm" {
  source = "./ami/amzn_linux_2023"
}

module "subnet4vm" {
  source = "./subnet"
  cidr = var.vm_cidr
  vpc_id = module.vpc.id
}

module "vm" {
  source = "./vm"
  vm_spec = var.vm_spec
  ami = module.ami4vm.id
  subnet_id = module.subnet4vm.id
  allow_policy_arns = [data.aws_iam_policy.ssmManagedPolicy.arn]
}

# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
data "aws_iam_policy" "ssmManagedPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
/*
data "aws_iam_policy_document" "override" {
  statement {

    effect = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
    principals {
      
    }
    condition {
      
    }
  }
}
*/