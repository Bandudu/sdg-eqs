variable "net_name" {
    description = "The name assigned to the network"
} 

variable "cidr_gen" {
    default = ["10.0.0.0/16"]
  
}

variable "location" {}
variable "resource_group_name" {}
variable "environment" {}

#Subnets

variable "subnet_group_name" {}
variable "cidr_subnet" {
  default = ["10.0.1.0/24"]
}
variable "vm_iteration" {}




