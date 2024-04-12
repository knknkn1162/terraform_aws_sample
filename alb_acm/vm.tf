variable "vm_spec" {
  type = string
}

variable "vm1_cidr" {
  type = string
}

module "sg4vm" {
  source = "./sg"
  vpc_id = module.vpc.id
  ingress_ports = [80]
  cidrs =["0.0.0.0/0"]
}

module "vm1" {
  source = "./vm"
  vpc_id = module.vpc.id
  vm_subnet_id = module.subnet4vm1.id
  natgw_subnet_id = module.subnet4natgw.id
  vm_spec = var.vm_spec
  vm_cidr = var.vm1_cidr
  sg_ids = [module.sg4vm.id]
  user_data = <<-EOF
#!/bin/bash
sudo yum update
sudo yum install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo chmod 0666 /var/run/docker.sock
docker run -d -p 80:80 kennethreitz/httpbin
EOF
}