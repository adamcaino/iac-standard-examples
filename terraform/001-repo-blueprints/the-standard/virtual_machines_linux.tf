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
