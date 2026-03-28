output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = azurerm_virtual_network.workload.id
}

output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.windows.id
}

output "windows_vm_private_ip" {
  value = azurerm_network_interface.windows.private_ip_address
}

output "linux_vm_id" {
  value = azurerm_linux_virtual_machine.linux.id
}

output "linux_vm_private_ip" {
  value = azurerm_network_interface.linux.private_ip_address
}

output "keyvault_id_windows" {
  value = azurerm_key_vault.windows.id
}

output "keyvault_id_linux" {
  value = azurerm_key_vault.linux.id
}

output "keyvault_name_windows" {
  value = azurerm_key_vault.windows.name
}

output "keyvault_name_linux" {
  value = azurerm_key_vault.linux.name
}

output "nsg_id_windows" {
  value = azurerm_network_security_group.windows.id
}

output "nsg_id_linux" {
  value = azurerm_network_security_group.linux.id
}

output "route_table_id_windows" {
  value = azurerm_route_table.windows.id
}

output "route_table_id_linux" {
  value = azurerm_route_table.linux.id
}
