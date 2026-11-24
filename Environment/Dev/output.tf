output "resource_group_names" {
  description = "Map of region to Resource Group name"
  value       = { for region, mod in module.dev_infrastructure : region => mod.resource_group_name }
}

output "aks_cluster_names" {
  description = "Map of region to AKS cluster name"
  value       = { for region, mod in module.dev_infrastructure : region => mod.aks_cluster_name }
}

output "aks_kube_config_hosts" {
  description = "Map of region to AKS API server endpoint"
  sensitive   = true
  value       = { for region, mod in module.dev_infrastructure : region => mod.kube_config_host }
}