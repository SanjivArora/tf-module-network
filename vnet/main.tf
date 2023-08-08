resource "azurerm_virtual_network" "vnet" {
  name                = lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_cidr_block
  tags = merge(
    var.common_tags, {
      Name        = lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")
    }
  )
}

resource "azurerm_virtual_network_dns_servers" "vnet" {
  count = var.dns_servers != null ? 1 : 0
  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = var.dns_servers
}

resource "azurerm_monitor_diagnostic_setting" "ds" {
  name                          = "ds-${lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")}"
  target_resource_id            = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id    = var.log_analytics_workspace_id

  log {
    category        = "VMProtectionAlerts"
    enabled         = true
    retention_policy {
      days          = 0
      enabled       = false
    }
  }
  
  metric {
    category        = "AllMetrics"
    enabled         = true
    retention_policy {
      days          = 0
      enabled       = false
    }
  }
}