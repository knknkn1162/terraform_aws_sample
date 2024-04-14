locals {
  # for bastion
  db_user = "ssm-user"
}

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
sudo curl https://packages.microsoft.com/config/rhel/7/prod.repo -o /etc/yum.repos.d/msprod.repo
sudo ACCEPT_EULA=Y yum -y install mssql-tools unixODBC-devel
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /home/${local.db_user}/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /home/${local.db_user}/.bashrc
source /home/${local.db_user}/.bashrc
# create database
${module.vanilla_mssql.connection_command} <<-TSQL
create database ${var.db_name};
go
TSQL
EOF
  # depends_on = [
  #   module.vanilla_mssql.id
  # ]
}