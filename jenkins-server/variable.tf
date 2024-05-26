variable "vpc_cide" {
  description = "VPC CIDR"
  type = string
}




variable "instance_type" {
    description = "instance_type"
    type = string
  
}

variable "key_name" {
    description = "key_name"
    type = string
  
}

variable "subnet_id" {
    description = "subnet_id"
    type = list(string)
  
}


