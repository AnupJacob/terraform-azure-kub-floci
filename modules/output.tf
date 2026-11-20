output "resource_group_name" {
  description = "Provisioned Azure Resource Group name"
  value       = azurerm_resource_group.azure-rg.name
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.azure-virtual-network.id
}

output "aks_cluster_name" {
  description = "Provisioned AKS Cluster name"
  value       = azurerm_kubernetes_cluster.azure-kube-cluster-main.name
}

output "kube_config_host" {
  description = "Kubernetes API server host"
  value       = try(azurerm_kubernetes_cluster.azure-kube-cluster-main.kube_config[0].host, null)
  sensitive   = true
}

output "client_certificate" {
  description = "Base64 encoded client certificate"
  value       = try(azurerm_kubernetes_cluster.azure-kube-cluster-main.kube_config[0].client_certificate, null)
  sensitive   = true
}

output "client_key" {
  description = "Base64 encoded client key"
  value       = try(azurerm_kubernetes_cluster.azure-kube-cluster-main.kube_config[0].client_key, null)
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Base64 encoded cluster CA certificate"
  value       = try(azurerm_kubernetes_cluster.azure-kube-cluster-main.kube_config[0].cluster_ca_certificate, null)
  sensitive   = true
}
