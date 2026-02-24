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
