resource "azurerm_virtual_network" "aks" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.0.0/16"
  }
}