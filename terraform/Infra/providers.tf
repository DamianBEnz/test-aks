terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.15.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "CE-PL-IT-DamianM-test"
        storage_account_name = "terraformtestdm"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }

}


provider "azurerm" {
  features {}
}