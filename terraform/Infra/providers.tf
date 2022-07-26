terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.15.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "Terraform-test-rg"
        storage_account_name = "terraformtestdm"
        container_name       = "tfstate"
        key                  = "qEdmI6mktq8V5S13O/hiNyIBzT29FduSUQBaYrvsp6pyN0L03++MO/OQokDI+2KDhxd7EWmu1u7U+AStHlzX+w=="
    }

}


provider "azurerm" {
  features {}
}