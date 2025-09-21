#creating sg for alb
resource "aws_security_group" "alb" {
  name        = "alb"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_inbound_1" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.port_80
  ip_protocol       = "tcp"
  to_port           = var.port_80
}

resource "aws_vpc_security_group_ingress_rule" "alb_inbound_2" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.port_443
  ip_protocol       = "tcp"
  to_port           = var.port_443
}



resource "aws_vpc_security_group_egress_rule" "alb_outbound"{
  security_group_id = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.app.id
  ip_protocol = "tcp"
  from_port = var.port_443
  to_port = var.port_443
}

resource "aws_vpc_security_group_egress_rule" "alb_outbound2"{
  security_group_id = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.app.id
  ip_protocol = "tcp"
  from_port = var.port_80
  to_port = var.port_80
}



#creating sg for bastion host
resource "aws_security_group" "bastionhost" {
  name        = "bastionhost"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "bastion host"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_bastion" {
  security_group_id = aws_security_group.bastionhost.id
  cidr_ipv4         = "88.97.176.219/32"
  from_port         = var.ssh
  ip_protocol       = "tcp"
  to_port           = var.ssh
}

resource "aws_vpc_security_group_egress_rule" "oubound_bastion"{
  security_group_id = aws_security_group.bastionhost.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


#creating sg for priavte ec2s app
resource "aws_security_group" "app" {
  name        = "apptier"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "apptier"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_apptier" {
  security_group_id = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.bastionhost.id
  ip_protocol = "tcp"
  from_port = var.ssh
  to_port = var.ssh
}

resource "aws_vpc_security_group_ingress_rule" "inbound_apptier_2" {
  security_group_id = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id
  ip_protocol = "tcp"
  from_port = var.port_443
  to_port = var.port_443
}


resource "aws_vpc_security_group_ingress_rule" "inbound_apptier_3" {
  security_group_id = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id
  ip_protocol = "tcp"
  from_port = var.port_80  
  to_port = var.port_80
}

resource "aws_vpc_security_group_egress_rule" "outbound_apptier" {
  security_group_id = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.rds.id
  ip_protocol = "tcp"
  from_port = var.rds_port  #this is port nuumber for database
  to_port = var.rds_port
}

#allow outbound now 
resource "aws_vpc_security_group_egress_rule" "outbound_apptier_2" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


#creating sg for rds 
resource "aws_security_group" "rds" {
  name        = "rds"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "rds"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rds" {
  security_group_id = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.app.id
  ip_protocol = "tcp"
  from_port = var.rds_port #this is port nuumber for database
  to_port = var.rds_port
}


