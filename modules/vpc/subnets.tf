#creating the subnets for AZ's
resource "aws_subnet" "public_subnet_az1" {
  vpc_id     = aws_vpc.terraform_assignment.id
  cidr_block = "10.0.0.0/20"
  availability_zone = var.availability_zone_1
  
  tags = {
    Name = "public_subnet_az1"

  }
} 


resource "aws_subnet" "public_subnet_az2" {
  vpc_id     = aws_vpc.terraform_assignment.id
  cidr_block = "10.0.16.0/20"
  availability_zone = var.availability_zone_2

  tags = {
    Name = "public_subnet_az2"
  }
} 
  resource "aws_subnet" "private_subnet_az1" {
  vpc_id     = aws_vpc.terraform_assignment.id
  cidr_block = "10.0.128.0/20"
  availability_zone = var.availability_zone_1

  tags = {
    Name = "private_subnet_az1"
  }
}

  resource "aws_subnet" "private_subnet_az2" {
  vpc_id     = aws_vpc.terraform_assignment.id
  cidr_block = "10.0.144.0/20"
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private_subnet_az2"
  }
}

  resource "aws_subnet" "private_subnet_rds" {
  vpc_id     = aws_vpc.terraform_assignment.id
  cidr_block = "10.0.160.0/20"
  availability_zone = var.availability_zone_1
  
  
  tags = {
    Name = "private_subnet_rds"
  }
}

  resource "aws_subnet" "private_subnet_rds_2" {
  vpc_id     = aws_vpc.terraform_assignment.id
  cidr_block = "10.0.176.0/24"
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private_subnet_rds_2"
  }
}

# creting route table pointing to internet gateway
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.terraform_assignment.id
  

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "route_to_igw"
  }
}

# creting route table pointing to nat gateway
resource "aws_route_table" "route_nat" {
  vpc_id = aws_vpc.terraform_assignment.id

 route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
 }
    tags = {
    Name = "route_to_nat"
  }
}

# creating route table for rds
resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.terraform_assignment.id
  
  # Initially I added this route, but later realised it wasn’t needed
# route {
#   cidr_block = "10.0.0.0/16"
#   gateway_id = "local"
# }

  tags = {
    Name = "rds"
  }
}


# now will route all subnets to correct routing table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.route_nat.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.route_nat.id
}

resource "aws_route_table_association" "e" {
  subnet_id      = aws_subnet.private_subnet_rds.id
  route_table_id = aws_route_table.rds.id
}

resource "aws_route_table_association" "f" {
  subnet_id      = aws_subnet.private_subnet_rds_2.id
  route_table_id = aws_route_table.rds.id
}