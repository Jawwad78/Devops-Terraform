variable "http" {
  description = "port of http"
  type = number
}

variable "https" {
  description = "port of https"
  type = number
}

variable "public_subnet_1" {
    description = "public subnet"
    type = string
}

variable "public_subnet_2" {
    description = "second public subnet"
    type = string
}

variable "alb_sg_id" {
    description = "alb sgs"
    type = string
}

variable "first_app_ec2" {
    description = "1st app"
    type = string
}

variable "second_app_ec2" {
    description = "1st app"
    type = string
}

variable "aws_vpc_id" {
    description = "VPC ID"
    type = string
}