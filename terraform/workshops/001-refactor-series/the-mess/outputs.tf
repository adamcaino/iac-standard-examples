output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet_main_network_prod_uat.id
}

output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.windows_machine_config_prod_abc.id
}

output "windows_vm_private_ip" {
  value = azurerm_network_interface.windows_nic_1.private_ip_address
}

output "linux_vm_id" {
  value = azurerm_linux_virtual_machine.linux_machine_uat_prod_environment_server.id
}

output "linux_vm_private_ip" {
  value = azurerm_network_interface.linux_nic_prod.private_ip_address
}

output "keyvault_id" {
  value = azurerm_key_vault.shared_vault_for_everything.id
}

output "keyvault_name" {
  value = azurerm_key_vault.shared_vault_for_everything.name
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg_shared_everywhere.id
}

output "route_table_id" {
  value = azurerm_route_table.rt_main_routes_config.id
}
