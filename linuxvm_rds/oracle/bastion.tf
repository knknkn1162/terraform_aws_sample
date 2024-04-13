module "ami4bastion" {
  source = "./ami/amzn_linux_2023"
}

module "bastion" {
  source = "./bastion"
  ami = module.ami4bastion.id
  subnet_id = module.subnet4public.id
  vm_spec = var.bastion_spec
  user_data = <<-EOF
#!/bin/bash
sudo yum update
sudo yum -y install https://download.oracle.com/otn_software/linux/instantclient/1922000/oracle-instantclient19.22-basic-19.22.0.0.0-1.x86_64.rpm
sudo yum -y install https://download.oracle.com/otn_software/linux/instantclient/1922000/oracle-instantclient19.22-sqlplus-19.22.0.0.0-1.x86_64.rpm
sudo yum -y install https://download.oracle.com/otn_software/linux/instantclient/1922000/oracle-instantclient19.22-tools-19.22.0.0.0-1.x86_64.rpm
EOF
}