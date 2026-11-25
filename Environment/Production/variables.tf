variable "subscription_id" {
  type        = string
  description = "Azure subscription_id"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant_id"
}

variable "client_id" {
  type        = string
  description = "Azure client_id"
}

variable "client_secret" {
  type        = string
  description = "Azure client_secret"
}

variable "location" {
  type        = list(string)
  default     = ["West Europe", "North Europe"]
  description = "Infrastructure location"
}

variable "metadata_host" {
  type        = string
  default     = "host.docker.internal:4577"
  description = "Metadata_host for Floci"
}

variable "environments" {
  type        = string
  default     = "production"
  description = "production environment where the application is deployed to"
}

variable "aks_node_count" {
  default     = 4
  type        = number
  description = "Number of nodes for the production aks cluster"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.30"
  description = "Kubernetes version for production environment"
}

variable "app_subnet_cidr" {
  type        = string
  default     = "10.10.6.0/24"
  description = "application subnet cidr"
}

variable "aks_subnet_cidr" {
  type        = string
  default     = "10.10.5.0/24"
  description = "aks subnet cidr"
}

variable "vnet_cidr" {
  type        = string
  default     = "10.10.4.0/16"
  description = "vnet subnet cidr"
}

variable "aks_vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "VM size for the AKS cluster"
}

variable "project_name" {
  type        = string
  default     = "anups-azure-kube-floci"
  description = "Name of the Project"
}

variable "base_cidr_block" {
  type        = string
  description = "Base CIDR for Production environment"
}

variable "db_admin_user" {
  type        = string
  description = "Database admin username for prod"
}

variable "vm_admin_user" {
  type        = string
  description = "Admin username for the Azure Virtual Machines hosting the application for prod"
}

variable "db_name" {
  type        = string
  default     = "my_app_prod_db"
  description = "Database name for prod"
}