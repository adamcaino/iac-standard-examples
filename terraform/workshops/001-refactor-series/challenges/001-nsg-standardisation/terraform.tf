terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "challenge" {
  name     = "rg-iac-001-nsg-standardisation"
  location = "uksouth"

  tags = {
    project = "iac-standard"
  }
}
