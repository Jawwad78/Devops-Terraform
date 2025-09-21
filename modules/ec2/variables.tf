variable "public_subnet_id" {
    description = "Subnet id for bastion host"
    type = string
}

variable "private_subnet_az1" {
    description = "app 1 subnett"
    type = string
}

variable "private_subnet_az2" {
    description = "app 2 subnett"
    type = string
}

variable "app_sg_id" {
    description = "apps sgs"
    type = string
}

variable "bastion_sg_id" {
    description = "bastion sgs"
    type = string
}

variable "ami" {
    description = "amis"
    type = string
}

variable "instance_type" {
    description = "instance_type"
    type = string
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name to use"
}

variable "db_name" {
    description = "Database name for WordPress"
    type = string
}

variable "db_user" {
    type = string
    description = "datbase user"
}

  variable "db_password" {
    type = string
    sensitive = true
    description = "datbase password"
  }

   variable "db_rds_host" {
    type = string
    description = "RDS endpoint"
  }