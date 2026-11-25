output "resource_group_names" {
  description = "Map of region to Resource Group name"
  value       = { for region, mod in module.prod_infrastructure : region => mod.resource_group_name }
}

output "aks_cluster_names" {
  description = "Map of region to AKS cluster name"
  value       = { for region, mod in module.prod_infrastructure : region => mod.aks_cluster_name }
}

output "aks_kube_config_hosts" {
  description = "Map of region to AKS API server endpoint"
  sensitive   = true
  value       = { for region, mod in module.prod_infrastructure : region => mod.kube_config_host }
}

output "jumpbox_public_ips" {
  description = "Map of region to Jumpbox Public IP addresses"
  value       = { for region, mod in module.prod_infrastructure : region => mod.jumpbox_public_ip }
}

output "private_app_vm_ip" {
  description = "Map of region to Private my App VM IP addresses"
  value       = { for region, mod in module.prod_infrastructure : region => mod.private_app_vm_ip }
}

output "vm_ssh_private_key" {
  description = "Generated SSH private key for Jumpbox and Private VMs"
  value       = { for region, mod in module.prod_infrastructure : region => mod.vm_ssh_private_key }
  sensitive   = true
}

output "postgres_fully_qualified_domain_name" {
  description = "Private Fully Qualified Domain Name of the PostgreSQL Server"
  value       = { for region, mod in module.prod_infrastructure : region => mod.postgres_fqdn }
}

output "postgres_database_names" {
  description = "Map of region to PostgreSQL database name"
  value       = { for region, mod in module.prod_infrastructure : region => mod.postgres_db_name }
}

output "postgres_admin_password" {
  description = "Generated PostgreSQL administrator password"
  value       = { for region, mod in module.prod_infrastructure : region => mod.postgres_admin_password }
  sensitive   = true
}