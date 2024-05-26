variable "vpc_cide" {
  description = "VPC CIDR"
  type = string
}

variable "subnet_id" {
    description = "subnet_id"
    type = list(string)
  
}

variable "private_subnet_id" {
    description = "pri_subnet_id"
    type = list(string)
  
}

