variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

module "ami4vm" {
  source = "../ami/amzn_linux_2023"
}

resource "aws_instance" "bastion" {
  ami                    = module.ami4vm.id
  instance_type          = var.vm_spec
  subnet_id              = var.subnet_id
}

# route table(private)
resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "example" {
  subnet_id = var.subnet_id
  route_table_id = aws_route_table.example.id
}