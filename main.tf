resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.vnet_location
  name                = "${var.environment}-${var.solution}-vnet-${var.location_short_ae}-1"
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers

  tags = merge(
    var.common_tags, {
      Name        = "${var.environment}-${var.solution}-vnet-${var.location_short_ae}-1"
    }
  )
}

resource "azurerm_subnet" "subnet" {
  count = length(var.subnet_names)

  address_prefixes                               = [var.subnet_prefixes[count.index]]
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
#   enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false)
#   enforce_private_link_service_network_policies  = lookup(var.subnet_enforce_private_link_service_network_policies, var.subnet_names[count.index], false)
  # service_endpoints                              = lookup(var.subnet_service_endpoints, var.subnet_names[count.index], null)

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

#### NSG and route table association to subnet
locals {
  azurerm_subnets = {
    for index, subnet in azurerm_subnet.subnet :
    subnet.name => subnet.id
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

###Network watcher

# resource "azurerm_network_watcher" "network_watcher" {
#   name                = "${var.environment}-${var.solution}-networkwatcher-${var.location_short_ae}-1"
#   location            = var.vnet_location
#   resource_group_name = var.resource_group_name

#     tags = merge(
#     var.common_tags, {
#       Name = "${var.environment}-${var.solution}-networkwatcher-${var.location_short_ae}-1"
#     }
#   )
# }