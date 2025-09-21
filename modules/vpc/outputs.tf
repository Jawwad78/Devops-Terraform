output "vpc_id" {
 description = "the id of vpc" 
 value = aws_vpc.terraform_assignment.id
}

output "internet_gateway" {
  description = "internet gateway"
  value = aws_internet_gateway.igw.id
}

output "nat_gateway" {
  description = "NAT gateway"
  value = aws_nat_gateway.example.id
}