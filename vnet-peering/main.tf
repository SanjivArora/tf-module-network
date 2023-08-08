resource "azurerm_virtual_network_peering" "hub" {
  count = var.peer_type == "hub" ? 1 : 0  
  name                      = "hub-to-${var.remote_vnet_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.source_vnet_name
  remote_virtual_network_id = var.remote_vnet_id
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "peer" {
  count = var.peer_type == "peer" ? 1 : 0  
  name                      = "peer-to-${var.remote_vnet_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.source_vnet_name
  remote_virtual_network_id = var.remote_vnet_id
  use_remote_gateways       = true
}
