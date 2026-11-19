terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Production-Azure-Kub-Floci"
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