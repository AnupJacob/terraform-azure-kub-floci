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
  type        = string
  default     = "West Europe"
  description = "Infrastructure location"
}

variable "metadata_host" {
  type        = string
  default     = "host.docker.internal:4577"
  description = "Metadata_host for Floci"
}