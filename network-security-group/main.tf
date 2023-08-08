resource "azurerm_network_security_group" "nsg" {
  name                = lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
  tags = merge(
    var.common_tags, {
      Name        = lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")
    }
  )
}

resource "azurerm_monitor_diagnostic_setting" "ds" {
  name                       = "ds-${lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")}"
  target_resource_id         = azurerm_network_security_group.nsg.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "NetworkSecurityGroupEvent"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  log {
    category = "NetworkSecurityGroupRuleCounter"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }

}