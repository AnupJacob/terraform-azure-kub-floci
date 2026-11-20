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