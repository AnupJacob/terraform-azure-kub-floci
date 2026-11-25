module "prod_infrastructure" {
  for_each = toset(var.location)
  source   = "../../modules"

  project_name = var.project_name
  location     = each.value
  environments = var.environments

  vnet_cidr       = var.vnet_cidr
  aks_subnet_cidr = var.aks_subnet_cidr
  app_subnet_cidr = var.app_subnet_cidr

  kubernetes_version = var.kubernetes_version
  aks_node_count     = var.aks_node_count
  aks_vm_size        = var.aks_vm_size
  base_cidr_block    = var.base_cidr_block
  db_admin_user      = var.db_admin_user
  db_name            = var.db_name
  vm_admin_user      = var.vm_admin_user
}