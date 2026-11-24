variable "location" {
  type        = string
  description = "Infrastructure location"
}

variable "environments" {
  type        = string
  description = "Development environment where the application is deployed to"
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes for the development aks cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "app_subnet_cidr" {
  type        = string
  description = "application subnet cidr"
}

variable "aks_subnet_cidr" {
  type        = string
  description = "aks subnet cidr"
}

variable "vnet_cidr" {
  type        = string
  description = "vnet subnet cidr"
}

variable "aks_vm_size" {
  type        = string
  description = "VM size for the AKS cluster"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

# Append to modules/variables.tf
variable "public_subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "db_subnet_cidr" {
  type    = string
  default = "10.10.3.0/24"
}

variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "vm_admin_user" {
  type    = string
}

variable "postgres_version" {
  type    = string
  default = "16"
}

variable "db_admin_user" {
  type    = string
}

variable "db_storage_mb" {
  type    = number
  default = 32768
}

variable "db_sku_name" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "base_cidr_block" {
  description = "Environment supernet (e.g., 10.0.0.0/12 for Dev, 10.16.0.0/12 for Staging, 10.32.0.0/12 for Prod)"
  type        = string
}

variable "region_index" {
  description = "Zero-based index of the region within the environment (0, 1, 2...)"
  type        = number
  default     = 0
}

variable "db_name_prefix" {
  description = "Base application database name"
  type        = string
  default     = "appdb"
}

variable "db_name" {
  description = "Name of the database"
  type    = string
}
