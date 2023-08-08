resource "azurerm_route_table" "rt" {
  name                          = lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation


  dynamic "route" {
    for_each = var.routes
    content {
      name                       = route.value["name"]
      address_prefix             = route.value["address_prefix"]
      next_hop_type              = route.value["next_hop_type"]
      next_hop_in_ip_address     = route.value["next_hop_in_ip_address"]

    }
  }

  tags = merge(
    var.common_tags, {
      Name        = lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")
    }
  )
}

