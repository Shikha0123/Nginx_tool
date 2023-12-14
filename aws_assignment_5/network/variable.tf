variable "vpc_name" {
  type = string   
}
variable "tenancy" {
    type = string
}
variable "vpc_cidr" {
  type = string  
}
variable "public_subnet_names" {
  type = list(string)  
}
variable "pub_cidr" {
  type = list(string)    
}
variable "private_subnet_names" {
  type = list(string)    
}
variable "pv_cidr" {
  type = list(string)    
}
variable "igw_name" {
  type = string   
}
variable "nat_name" {
  type = string   
}
# variable "eip" {
#   type = string   
# }
variable "public_route_table_names" {
  type = string   
}
variable "private_route_table_names" {
  type = string   
}