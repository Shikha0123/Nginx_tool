variable "vpcname" {
  type = string   
  default = "ninja-vpc-01"
}
variable "vpctenancy" {
    type = string
    default = "default"
}
variable "vpccidr" {
  type = string  
  default = "10.100.0.0/16"
}
variable "pub_sub_names" {
  type = list(string)  
  default = ["ninja-pub-sub-01", "ninja-pub-sub-02"]
}
variable "pubcidr" {
  type = list(string)    
  default = ["10.100.1.0/24", "10.100.2.0/24"]
}
variable "pvt_sub_names" {
  type = list(string)    
  default = ["ninja-priv-sub-01", "ninja-priv-sub-02"]
}
variable "pvtcidr" {
  type = list(string)    
  default = ["10.100.4.0/24", "10.100.6.0/24"]
}
variable "pub_instance_name" {
  type = string 
  default = "bastion-instance"
}
variable "pvt_instance_name" {
  type = string    
  default = "private-instance"
}
variable "igwname" {
  type = string   
  default = "ninja-igw-01"
}
variable "natname" {
  type = string   
  default = "ninja-nat-01"
}
variable "public_rt_names" {
  type = string   
  default = "ninja-route-pub-01"
}
variable "private_rt_names" {
  type = string   
  default = "ninja-route-priv-01"
}
variable "instancetype" {
  type = string   
  default = "t2.micro"
}
variable "seqgrp" {
  type = string   
  default = "SSH"
}
variable "keyname" {
  type = string
}