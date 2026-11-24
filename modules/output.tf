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


# Append to modules/output.tf
output "jumpbox_public_ip" {
  description = "Public IP address of the Jumpbox VM"
  value       = azurerm_public_ip.jumpbox.ip_address
}

output "private_app_vm_ip" {
  description = "Private IP address of the App VM"
  value       = azurerm_network_interface.private_my_app_ni.private_ip_address
}

output "vm_ssh_private_key" {
  description = "Generated SSH private key for Jumpbox and Private VMs"
  value       = tls_private_key.vm_ssh.private_key_pem
  sensitive   = true
}

output "postgres_fqdn" {
  description = "Private Fully Qualified Domain Name(FQDN) of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "postgres_admin_password" {
  description = "Generated PostgreSQL administrator password"
  value       = random_password.db_admin.result
  sensitive   = true
}

output "postgres_db_name" {
  description = "Provisioned PostgreSQL database name"
  value       = azurerm_postgresql_flexible_server_database.app.name
}