# Subnet for PostgreSQL Flexible Server
resource "azurerm_subnet" "db" {
  name                 = "${local.name_prefix}-db-subnet"
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = azurerm_virtual_network.azure-virtual-network.name
  address_prefixes     = [var.db_subnet_cidr]
#  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Private DNS Zone for PostgreSQL VNet Integration
resource "azurerm_private_dns_zone" "postgres_dns_zone" {
  name                = "${local.name_prefix}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.azure-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_zone_vn_link" {
  name                  = "${local.name_prefix}-pg-vnet-link"
  private_dns_zone_id   = azurerm_private_dns_zone.postgres_dns_zone.id
  virtual_network_id    = azurerm_virtual_network.azure-virtual-network.id
  registration_enabled  = false
}

# Random Password for PostgreSQL Admin
resource "random_password" "db_admin" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Managed PostgreSQL Flexible Server (Private VNet Integrated)
resource "azurerm_postgresql_flexible_server" "main" {
  name                          = "${local.name_prefix}-psql"
  resource_group_name           = azurerm_resource_group.azure-rg.name
  location                      = azurerm_resource_group.azure-rg.location
  version                       = var.postgres_version
  delegated_subnet_id           = azurerm_subnet.db.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres_dns_zone.id
  public_network_access_enabled = false
  administrator_login           = var.db_admin_user
  administrator_password        = random_password.db_admin.result
  storage_mb                    = var.db_storage_mb
  sku_name                      = var.db_sku_name
  zone                          = "1"

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.postgres_dns_zone_vn_link
  ]
}

resource "azurerm_postgresql_flexible_server_database" "app" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
