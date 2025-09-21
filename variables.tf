variable "aws_instance" {
  type = string
  description = "ec2's version "
}

variable "ami" {
    type = string
    description = "ami for ubuntu "
}


variable "availability_zone_1" {
    type = string
    description = "1st az location "
}

variable "availability_zone_2" {
    type = string
    description = "2nd az location "
}


variable "port_80" {
    type = number
    description = "port for http that we use"
}

variable "port_443" {
    type = number
    description = "port for https that we use"
}


variable "ssh" {
    type = number
    description = "port for ssh that we use"
}

variable "rds_port" {
    type = number
    description = "port for rds that we use"
  
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

  variable "db_name" {
  description = "Database name for WordPress"
  type        = string
}
