output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.workload.name
}

output "windows_vm_private_ip" {
  value = azurerm_network_interface.windows.private_ip_address
}

output "linux_vm_private_ip" {
  value = azurerm_network_interface.linux.private_ip_address
}
