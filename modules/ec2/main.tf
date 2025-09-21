resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "bastion"
  }
}

#this is first ec2 
resource "aws_instance" "first_app" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = var.private_subnet_az1
  vpc_security_group_ids  = [var.app_sg_id]
  key_name = var.key_name

 tags = {
    Name = "app 1"
  }

  
  #now adding user data script to install apache +php +wordpress
  user_data   = templatefile("${path.module}/wordpress.tpl", {
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
  db_host     = var.db_rds_host
  })
}

#2nd ec2 instance 
resource "aws_instance" "second_app" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = var.private_subnet_az2
  vpc_security_group_ids  = [var.app_sg_id]
  key_name = var.key_name

tags = {
    Name = "app 2"
  }

 user_data   = templatefile("${path.module}/wordpress.tpl", {
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
  db_host     = var.db_rds_host
  })
}
