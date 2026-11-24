locals {
  location_slug = lower(replace(var.location, " ", ""))
  name_prefix   = "${var.project_name}-${var.environments}-${local.location_slug}"
#}


#locals {
#  env_slug      = lower(trimspace(var.environments))
#  location_slug = lower(replace(var.location, " ", ""))
#  name_prefix   = "${var.project_name}-${local.env_slug}-${local.location_slug}"

  # Unique /16 VNet for this region from the environment's /12 supernet
  vnet_cidr = cidrsubnet(var.base_cidr_block, 4, var.region_index)

  # Four non-overlapping /24 subnets inside the regional /16 VNet
  public_subnet_cidr = cidrsubnet(local.vnet_cidr, 8, 0) # e.g., 10.0.0.0/24
  aks_subnet_cidr    = cidrsubnet(local.vnet_cidr, 8, 1) # e.g., 10.0.1.0/24
  app_subnet_cidr    = cidrsubnet(local.vnet_cidr, 8, 2) # e.g., 10.0.2.0/24
  db_subnet_cidr     = cidrsubnet(local.vnet_cidr, 8, 3) # e.g., 10.0.3.0/24

  # Environment and region-specific PostgreSQL database name (alphanumeric + underscore only)
  db_name = "${var.db_name_prefix}_${var.environments}_${local.location_slug}"
}
