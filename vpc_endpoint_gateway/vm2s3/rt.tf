module "rt4vm" {
  source = "./rt"
  vpc_id = module.vpc.id
  subnet_ids = [module.subnet4vm.id]
  #subnet_id4natgw = module.subnet4public.id
}

module "rt4public" {
  source = "./rt/igw"
  vpc_id = module.vpc.id
  subnet_ids = [module.subnet4public.id]
}