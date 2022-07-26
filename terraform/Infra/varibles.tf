variable "resource_group_name" {
  default = "aks"
  type = string
}

variable "location" {
  default = "West Europe"
  type = string
}

variable "environment" {
  type = string  
}


variable "aks_vm_standard" {
  type = string
  default = "standard_D2as_v5"
}

variable "aks_node_count" {
  type = number
  default = 2
}