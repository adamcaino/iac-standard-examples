resource "azurerm_network_interface" "windows" {
  name                = "nic-win-${var.workload_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip_config_windows"
    subnet_id                     = azurerm_subnet.windows.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows" {
  name                = "vm-win-${var.workload_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  admin_username = "localadmin"
  admin_password = azurerm_key_vault_secret.windows_admin.value

  network_interface_ids = [
    azurerm_network_interface.windows.id,
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
