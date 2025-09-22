#call the vpc module
module "vpc" {
  source = "./modules/vpc"
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  port_80             = var.port_80
  port_443            = var.port_443
  ssh                 = var.ssh
  rds_port            = var.rds_port
}

#call ec2 module
module "ec2" {
  source = "./modules/ec2"

  public_subnet_id   = module.vpc.aws__public_subnet_az1
  private_subnet_az1 = module.vpc.aws__private_subnet_az1
  private_subnet_az2 = module.vpc.aws__private_subnet_az2
  app_sg_id          = module.vpc.app_security
  bastion_sg_id      = module.vpc.bastionhost_security
  ami                = var.ami
  instance_type      = var.aws_instance
  key_name           = aws_key_pair.my_key.key_name
  db_name            = var.db_name
  db_user            = var.db_user
  db_password        = var.db_password
  db_rds_host        = module.rds.rds_database_endpoint
}

module "rds" {
  source = "./modules/rds"
db_name = var.db_name
db_user = var.db_user
db_password = var.db_password
rds_security_group = module.vpc.rds_security
private_subnet_rds_1 = module.vpc.aws__rds_subnet_az1
private_subnet_rds_2 = module.vpc.aws__rds_subnet_az2
}

module "alb" {
  source = "./modules/alb"
  
  http = var.port_80 
  https =   var.port_443
  public_subnet_1 = module.vpc.aws__public_subnet_az1
  public_subnet_2 = module.vpc.aws__public_subnet_az2
  alb_sg_id = module.vpc.alb_security
  first_app_ec2= module.ec2.id_app1
  second_app_ec2 =  module.ec2.id_app2
  aws_vpc_id = module.vpc.vpc_id
}