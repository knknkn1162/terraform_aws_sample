variable "vpc_id" {
  type = string
}

variable "peer_vpc_id" {
  type = string
}

variable "rt_id" {
  type = string
}

variable "peer_rt_id" {
  type = string
}

resource "aws_vpc_peering_connection" "requester" {
  # must be managed if connecting cross-account.
  #peer_owner_id = ...
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  auto_accept               = true
}

data "aws_vpc" "main" {
   id = var.vpc_id
}

data "aws_vpc" "peer" {
  id = var.peer_vpc_id
}

module "peering1" {
  source = "../rt2subnets/route/peering"
  rt_id = var.rt_id
  dest_cidr = data.aws_vpc.peer.cidr_block
  peering_id = aws_vpc_peering_connection.requester.id
}

module "peering2" {
  source = "../rt2subnets/route/peering"
  rt_id = var.peer_rt_id
  dest_cidr = data.aws_vpc.main.cidr_block
  peering_id = aws_vpc_peering_connection.requester.id
}