resource "azurerm_subnet" "subnet" {
  count = length(var.subnet_names)
  address_prefixes                               = [var.subnet_prefixes[count.index]]
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name


  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, var.subnet_names[count.index], {})
    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "vnet" {
  for_each = var.nsg_ids
  network_security_group_id = each.value
  subnet_id                 = local.azurerm_subnets[each.key]
}

resource "azurerm_subnet_route_table_association" "vnet" {
  for_each = var.route_tables_ids
  route_table_id = each.value
  subnet_id      = local.azurerm_subnets[each.key]
}