terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name}-${var.env}"
  location = var.loc
}

resource "azurerm_virtual_network" "vnet_main_network_prod_uat" {
  name                = "vn-${var.name}-net"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet_windows" {
  name                 = "snet-win-${var.name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_main_network_prod_uat.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_linux" {
  name                 = "snet-lin-${var.name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_main_network_prod_uat.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "nsg_shared_everywhere" {
  name                = "nsg-everything-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRDP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowEverythingElse"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "assoc_1" {
  subnet_id                 = azurerm_subnet.subnet_windows.id
  network_security_group_id = azurerm_network_security_group.nsg_shared_everywhere.id
}

resource "azurerm_subnet_network_security_group_association" "assoc_2" {
  subnet_id                 = azurerm_subnet.subnet_linux.id
  network_security_group_id = azurerm_network_security_group.nsg_shared_everywhere.id
}

resource "azurerm_route_table" "rt_main_routes_config" {
  name                = "rt-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "rt_assoc_1" {
  subnet_id      = azurerm_subnet.subnet_windows.id
  route_table_id = azurerm_route_table.rt_main_routes_config.id
}

resource "azurerm_subnet_route_table_association" "rt_assoc_2" {
  subnet_id      = azurerm_subnet.subnet_linux.id
  route_table_id = azurerm_route_table.rt_main_routes_config.id
}

resource "azurerm_key_vault" "shared_vault_for_everything" {
  name                        = "kv${var.name}${var.env}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
}

resource "azurerm_key_vault_secret" "windows_password_1" {
  name         = "vm-win-admin-pass"
  value        = var.admin_password_windows
  key_vault_id = azurerm_key_vault.shared_vault_for_everything.id
}

resource "azurerm_key_vault_secret" "linux_password_2" {
  name         = "vm-lin-admin-pass"
  value        = var.admin_password_linux
  key_vault_id = azurerm_key_vault.shared_vault_for_everything.id
}

data "azurerm_client_config" "current" {}

resource "azurerm_network_interface" "windows_nic_1" {
  name                = "nic-win-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip_config_windows"
    subnet_id                     = azurerm_subnet.subnet_windows.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "linux_nic_prod" {
  name                = "nic-lin-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip_config_linux"
    subnet_id                     = azurerm_subnet.subnet_linux.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows_machine_config_prod_abc" {
  name                = "vm-win-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  admin_username = "localadmin"
  admin_password = var.admin_password_windows

  network_interface_ids = [
    azurerm_network_interface.windows_nic_1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "linux_machine_uat_prod_environment_server" {
  name                = "vm-lin-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.linux_nic_prod.id,
  ]

  admin_password                  = var.admin_password_linux
  disable_password_authentication = false

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
