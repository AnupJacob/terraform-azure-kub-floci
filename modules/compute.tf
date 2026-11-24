# Public Subnet for Jumpbox / Bastion VM
resource "azurerm_subnet" "public" {
  name                 = "${local.name_prefix}-public-subnet"
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = azurerm_virtual_network.azure-virtual-network.name
  address_prefixes     = [var.public_subnet_cidr]
}

# Network Security Group for Public Jumpbox (To Allow SSH)
resource "azurerm_network_security_group" "public" {
  name                = "${local.name_prefix}-public-nsg"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name

  security_rule {
    name                       = "AllowSSHInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ssh_cidr
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

# Generated SSH Key Pair for VMs
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Public IP & NIC for Jumpbox VM
resource "azurerm_public_ip" "jumpbox" {
  name                = "${local.name_prefix}-jumpbox-pip"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "jumpbox" {
  name                = "${local.name_prefix}-jumpbox-nic"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox.id
  }
}

# 1. Public Jumpbox Linux VM
resource "azurerm_linux_virtual_machine" "public_jumpbox_VM" {
  name                = "${local.name_prefix}-jumpbox-vm"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  size                = var.aks_vm_size
  admin_username      = var.vm_admin_user
  network_interface_ids = [
    azurerm_network_interface.jumpbox.id
  ]

  admin_ssh_key {
    username   = var.vm_admin_user
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# Network Interface for Private My App VM (No Public IP)
resource "azurerm_network_interface" "private_my_app_ni" {
  name                = "${local.name_prefix}-app-nic"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
  }
}

# 2. Private My App Linux VM
resource "azurerm_linux_virtual_machine" "private_app_vm" {
  name                = "${local.name_prefix}-my-app-vm"
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  size                = var.vm_size
  admin_username      = var.vm_admin_user
  network_interface_ids = [
    azurerm_network_interface.private_my_app_ni.id
  ]

  admin_ssh_key {
    username   = var.vm_admin_user
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
