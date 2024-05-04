variable "name" {
  type = string
}

data "aws_ami" "example" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.name]
  }
}

output "id" {
  value = data.aws_ami.example.id
}