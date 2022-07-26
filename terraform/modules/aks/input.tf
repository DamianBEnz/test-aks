variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "aks_dns_prefix" {
  type = string
}

variable "aks_vm_standard" {
  type = string
}

variable "aks__node_count" {
  type = number
}
