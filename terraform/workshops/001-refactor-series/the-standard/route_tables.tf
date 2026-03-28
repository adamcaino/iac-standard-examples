# Messy NSG Naming
resource "azurerm_route_table" "rt_win_dev" {
  name                = "rt-${var.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "rtassoc_win_dev" {
  subnet_id      = azurerm_subnet.windows.id
  route_table_id = azurerm_route_table.windows.id
}

# The IaC Standard Naming Convention
resource "azurerm_route_table" "linux" {
  name                = "rt-${var.name}-${var.environment}-${var.location_shortcode}-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "linux" {
  subnet_id      = azurerm_subnet.linux.id
  route_table_id = azurerm_route_table.linux.id
}







variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)"
  type        = string
}

variable "location_shortcode" {
  description = "A short code for the location (e.g., usw for US West)"
  type        = string
}
