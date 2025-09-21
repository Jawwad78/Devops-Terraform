resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = var.db_name # name of db
  engine               = "mysql" #Choice of database engine
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.rds_database.name #adding the name of the rds subnet group 
  username             = var.db_user
  password             = var.db_password
  skip_final_snapshot  = true  #Determines if a snapshot should be taken before deleting the database.
  vpc_security_group_ids = [var.rds_security_group]
  
  tags = {
    Name = "RDS"
  }
}

#attachind rds to subnet
resource "aws_db_subnet_group" "rds_database" {
  name       = "rds_subnet"
  subnet_ids = [var.private_subnet_rds_1, var.private_subnet_rds_2]
  tags = {
    Name = "My DB subnet group"
  }
}