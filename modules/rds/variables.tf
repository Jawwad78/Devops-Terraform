

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


variable "rds_security_group" {
    description = "rds sg"
    type = string
}

variable "private_subnet_rds_1" {
    description = "rds subnet"
    type = string
}

variable "private_subnet_rds_2" {
    description = "rds 2nd subnet"
    type = string
}