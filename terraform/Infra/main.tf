resource "azurerm_resource_group" "aks" {
    name = format ("%s-%s-%s", var.resource_group_name, var.environment, "rg")
    location = var.location 
}


resource "azurerm_virtual_network" "aks" {
  name                = format ("%s-%s",var.environment,"aks-vnet0")
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_container_registry" "aks" {
  name                = replace (format("%s%s%s", azurerm_resource_group.aks.name, var.environment ,"acr"),"-","")
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "Standard"
}


resource "azurerm_kubernetes_cluster" "aks" {
  name = format("%s-%s", var.environment, "aks")
  location = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix = format("%s%s",azurerm_resource_group.aks.name, var.environment)

  default_node_pool {
    name = "system"
    node_count = 1
    vm_size = "standard_D2as_v5"
  }

   identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "aks" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.aks.id
  skip_service_principal_aad_check = true
}