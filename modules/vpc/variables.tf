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

