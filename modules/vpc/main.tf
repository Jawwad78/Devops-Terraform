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
resource "aws_eip" "nat" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.igw]
}


#create a NAT gateway
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = aws_subnet.public_subnet_az1.id
  tags = {
    Name = "NAT gateway"
  }

  # making sure it depends ON then igw itself (optional)
  depends_on = [aws_internet_gateway.igw]
}

