resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-01"
  location            = azurerm_resource_group.challenge.location
  resource_group_name = azurerm_resource_group.challenge.name
}

resource "azurerm_network_security_group_rule" "inbound" {
  for_each = local.inbound_rules

  resource_group_name         = azurerm_resource_group.challenge.name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = lower("${lookup(each.value, "direction", "allow")}-${each.key}")
  priority                   = 100 + (index(keys(local.inbound_rules), each.key) * 10) # Calculate priority based on the index of the rule
  direction                  = "Inbound"                                               # Set direction to "Inbound" for all rules in this block
  access                     = lookup(each.value, "access", "allow")                   # Default to "allow" if not specified
  protocol                   = lookup(each.value, "protocol", "Tcp")                   # Default to "Tcp" if not specified
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
}

resource "azurerm_network_security_group_rule" "outbound" {
  for_each = local.outbound_rules

  resource_group_name         = azurerm_resource_group.challenge.name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = lower("${lookup(each.value, "direction", "allow")}-${each.key}")
  priority                   = 100 + (index(keys(local.outbound_rules), each.key) * 10) # Calculate priority based on the index of the rule
  direction                  = "Outbound"                                               # Set direction to "Outbound" for all rules in this block
  access                     = lookup(each.value, "access", "allow")                    # Default to "allow" if not specified
  protocol                   = lookup(each.value, "protocol", "Tcp")                    # Default to "Tcp" if not specified
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
}
