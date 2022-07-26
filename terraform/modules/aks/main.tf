resource "azurerm_kubernetes_cluster" "aks" {
  name = var.aks_name
  location = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = var.aks_dns_prefix
 
  default_node_pool {
    node_count = var.aks__node_count
    vm_size = var.aks_vm_standard
  }

}