resource "azurerm_resource_group" "azure-rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "azure-virtual-network" {
  name                = "${local.name_prefix}-vnet"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "aks-subnet" {
  name                 = "${local.name_prefix}-aks-subnet"
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = azurerm_virtual_network.azure-virtual-network.name
  address_prefixes     = [var.aks_subnet_cidr]
}

resource "azurerm_subnet" "app" {
  name                 = "${local.name_prefix}-app-subnet"
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = azurerm_virtual_network.azure-virtual-network.name
  address_prefixes     = [var.app_subnet_cidr]
}

resource "azurerm_network_security_group" "aks-security-group" {
  name                = "${local.name_prefix}-aks-nsg"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name

  security_rule {
    name                       = "AllowHTTPSInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "aks-sg-association" {
  subnet_id                 = azurerm_subnet.aks-subnet.id
  network_security_group_id = azurerm_network_security_group.aks-security-group.id
}

resource "azurerm_user_assigned_identity" "aks-user-identity" {
  name                = "${local.name_prefix}-aks-identity"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = azurerm_virtual_network.azure-virtual-network.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks-user-identity.principal_id
}

resource "azurerm_kubernetes_cluster" "azure-kube-cluster-main" {
  name                = "${local.name_prefix}-aks"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  dns_prefix          = "${local.name_prefix}-dns"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name           = "default"
    node_count     = var.aks_node_count
    vm_size        = var.aks_vm_size
    vnet_subnet_id = azurerm_subnet.aks-subnet.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks-user-identity.id]
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.240.0.0/16"
    dns_service_ip = "10.240.0.10"
  }

  node_provisioning_profile {
    mode = "Manual"
  }
  depends_on = [
    azurerm_role_assignment.aks_network_contributor
  ]
}