variable "resource_group_name" {}
variable "location" {}
variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string

  }))
}
variable "log_analytics_workspace_id" {}
variable "environment" {}
variable "solution" {}
variable "resource_name" {}
variable "location_short" {}
variable "instance_number" {}
variable "common_tags" {}
