terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

provider "azurerm" {
    
    subscription_id  = var.subscription_id
    client_id        = var.client_id 
    client_secret    = var.client_secret
    tenant_id        = var.tenant_id

    features {
    }
}

resource "azurerm_resource_group" "rg" {
    name        = "rg-terraform-cloud"
    location    = "eastus2"   

    tags        = {
      Environment = "Testing",
      Project     = "Terraform"
    }
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-dev"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}
