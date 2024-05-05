data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

output "ami" {
  value = data.aws_ami.amzn-linux-2023-ami.id
}