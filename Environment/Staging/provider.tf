terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Azure-Kub-Floci"
      name    = "terraform-azure-kub-floci-staging"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  use_cli                         = false
  environment                     = "staging"
  metadata_host                   = var.metadata_host
  resource_provider_registrations = "none"


  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "azure_rg_staging_floci" {
  name     = "azure_rg_staging_floci"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "azure-network-staging" {
  name                = "azure-network-dev"
  resource_group_name = azurerm_resource_group.azure_rg_staging_floci.name
  location            = azurerm_resource_group.azure_rg_staging_floci.location
  address_space       = ["10.0.1.0/16"]
}