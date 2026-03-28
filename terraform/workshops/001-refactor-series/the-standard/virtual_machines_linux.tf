resource "azurerm_network_interface" "linux" {
  name                = "nic-lin-${var.workload_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip_config_linux"
    subnet_id                     = azurerm_subnet.linux.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux" {
  name                = "vm-lin-${var.workload_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.linux.id,
  ]

  admin_password                  = azurerm_key_vault_secret.linux_admin.value
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
