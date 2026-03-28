# Virtual Network for the workload
moved {
  from = azurerm_virtual_network.vnet_main_network_prod_uat
  to   = azurerm_virtual_network.workload
}

# Subnet for Windows
moved {
  from = azurerm_subnet.subnet_windows
  to   = azurerm_subnet.windows
}

# Subnet for Linux
moved {
  from = azurerm_subnet.subnet_linux
  to   = azurerm_subnet.linux
}

# Linux VM
moved {
  from = azurerm_network_interface.linux_nic_prod
  to   = azurerm_network_interface.linux
}

moved {
  from = azurerm_linux_virtual_machine.linux_machine_uat_prod_environment_server
  to   = azurerm_linux_virtual_machine.linux
}

# Windows VM
moved {
  from = azurerm_network_interface.windows_nic_1
  to   = azurerm_network_interface.windows
}

moved {
  from = azurerm_windows_virtual_machine.windows_machine_config_prod_abc
  to   = azurerm_windows_virtual_machine.windows
}
