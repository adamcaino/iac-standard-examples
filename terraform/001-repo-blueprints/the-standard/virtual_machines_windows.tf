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
