resource "azurerm_resource_group" "aks" {
    name = format ("%s-%s-%s", var.resource_group_name, var.environment, "rg")
    location = var.location 
    tags = {
    environment = var.environment
  }
}

module "azurerm_virtual_network" {
  source = "../modules/networks"
  resource_group_name = azurerm_resource_group.aks.name
  network_name = format ("%s-%s-%s", var.resource_group_name, var.environment, "vnet")
  location = azurerm_resource_group.aks.location
}


module "azurerm_kubernetes_cluster" {
  source = "../modules/aks"
  aks_name = format("%s-%s-%s",var.resource_group_name, var.environment, "aks")
  location = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  aks_dns_prefix = format("%s%s",azurerm_resource_group.aks.name, var.environment)

  default_node_pool {
    name = "system"
    aks_node_count = var.aks_node_count
    aks_vm_standard = var.aks_vm_standard
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

   identity {
    type = "SystemAssigned"
  }
    network_profile {
    network_plugin    = "kubenet" 
  }
}

resource "azurerm_container_registry" "aks" {
  name                = replace (format("%s%s%s", azurerm_resource_group.aks.name, var.environment ,"acr"),"-","")
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "Standard"
  tags = {
    enviroment = var.environment
  }
}


resource "azurerm_role_assignment" "aks" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.aks.id
  skip_service_principal_aad_check = true
}




