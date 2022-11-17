terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.25.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}
