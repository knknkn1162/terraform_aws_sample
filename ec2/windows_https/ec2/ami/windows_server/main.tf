variable "ver" {
  type = number
}

variable "lang" {
  type = string
}

variable "has_gui" {
  type = bool
  default = true
}

locals {
  fullorcore = var.has_gui ? "Full" : "Core"
}

module "ami" {
  source = "../"
  name = "Windows_Server-${var.ver}-${var.lang}-${local.fullorcore}-Base-*"
}

output "id" {
  value = module.ami.id
}