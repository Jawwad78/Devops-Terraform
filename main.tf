#call the vpc module
module "vpc" {
  source = "./modules/vpc"

public_subnet_id = aws_subnet.public_subnet_az1.id
}

#call ec2 module
module "ec2" {
  source = "./modules/ec2"

public_subnet_id = aws_subnet.public_subnet_az1.id
private_subnet_az1 = aws_subnet.private_subnet_az1.id
private_subnet_az2 =aws_subnet.private_subnet_az2.id
app_sg_id     =  aws_security_group.app.id
bastion_sg_id = aws_security_group.bastionhost.id
ami           = var.ami
instance_type = var.aws_instance
key_name      = aws_key_pair.my_key.key_name
db_name       = var.db_name
db_user       = var.db_user
db_password   = var.db_password
db_rds_host =  module.rds.rds_database_endpoint
}

module "rds" {
  source = "./modules/rds"
db_name = var.db_name
db_user = var.db_user
db_password = var.db_password
rds_security_group = aws_security_group.rds.id
private_subnet_rds_1 = aws_subnet.private_subnet_rds.id
private_subnet_rds_2 = aws_subnet.private_subnet_rds_2.id
}

module "alb" {
  source = "./modules/alb"
  
  http =var.port_80 
  https =   var.port_443
  public_subnet_1 = aws_subnet.public_subnet_az1.id
  public_subnet_2 = aws_subnet.public_subnet_az2.id
  alb_sg_id = aws_security_group.alb.id
  first_app_ec2= module.ec2.id_app1
  second_app_ec2 =  module.ec2.id_app2
  aws_vpc_id = module.vpc.vpc_id
}