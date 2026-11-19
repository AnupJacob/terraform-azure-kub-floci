terraform {
  cloud {
    organization = "Application_Test"
    workspaces {
      project = "Development-Azure-Kub-Floci"
      name    = "terraform-azure-kub-floci-development"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}