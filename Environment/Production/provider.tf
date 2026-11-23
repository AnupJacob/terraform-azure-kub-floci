terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Anups-Azure-Kube-Floci"
      name    = "terraform-azure-kub-floci-prod"
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
  environment                     = "prod"
  metadata_host                   = var.metadata_host
  resource_provider_registrations = "none"

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

provider "kubernetes" {
  host                   = module.prod_infrastructure[var.location[0]].kube_config_host
  client_certificate     = base64decode(module.prod_infrastructure[var.location[0]].client_certificate)
  client_key             = base64decode(module.prod_infrastructure[var.location[0]].client_key)
  cluster_ca_certificate = base64decode(module.prod_infrastructure[var.location[0]].cluster_ca_certificate)
}