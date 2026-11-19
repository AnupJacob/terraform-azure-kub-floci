terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Staging-Azure-Kub-Floci"
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