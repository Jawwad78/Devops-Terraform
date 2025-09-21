# Create a VPC
resource "aws_vpc" "terraform_assignment" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform_assignment.id

  tags = {
    Name = "igw_assignment"
  }
}

#create an elastic ip for the nat gateway
resource "aws_eip" "lb" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.igw]
}


#create a NAT gateway
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.allocation_id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = " NAT gateway"
  }

  # making sure it depends ON then igw itself (optional)
  depends_on = [aws_internet_gateway.igw]
}

