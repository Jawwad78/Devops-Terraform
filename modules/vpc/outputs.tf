output "vpc_id" {
 description = "the id of vpc" 
 value = aws_vpc.terraform_assignment.id
}


output "alb_security" {
  description = "alb sg"
  value = aws_security_group.alb.id
}

output "rds_security" {
  description = "rds sg"
  value = aws_security_group.rds.id
}
output "bastionhost_security" {
  description = "bastion host sg"
  value = aws_security_group.bastionhost.id
}
output "app_security" {
  description = "app sg"
  value = aws_security_group.app.id
}

output "aws__public_subnet_az1" {
  description = "public subnet az1"
  value = aws_subnet.public_subnet_az1.id
}

output "aws__public_subnet_az2" {
  description = "public subnet az2"
  value = aws_subnet.public_subnet_az2.id
}

output "aws__private_subnet_az1" {
  description = "priavte subnet az1"
  value = aws_subnet.private_subnet_az1.id
}

output "aws__private_subnet_az2" {
  description = "priavte subnet az2"
  value = aws_subnet.private_subnet_az2.id
}

output "aws__rds_subnet_az1" {
  description = "rds az1"
  value = aws_subnet.private_subnet_rds.id
}

output "aws__rds_subnet_az2" {
  description = "rds az2"
  value = aws_subnet.private_subnet_rds_2.id
}