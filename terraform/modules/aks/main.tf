resource "azurerm_kubernetes_cluster" "aks" {
  name = var.aks_name
  location = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = var.aks_dns_prefix
 
  default_node_pool {
    node_count = var.aks_node_count
    vm_size = var.aks_vm_standard
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
    name = "system"
  }

  identity {
    type = "SystemAssigned"
  }
    network_profile {
    network_plugin    = "kubenet" 
  }

}