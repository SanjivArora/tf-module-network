variable "resource_group_name" {}
variable "location" {}
variable "vnet_cidr_block" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = []
}
variable "peer_type" {
    default = null
}
variable "remote_vnet_name" {
    default = null
}
variable "remote_vnet_id" {
    default = null
}
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}
variable "virtual_network_id" {
  default = null
}
variable "log_analytics_workspace_id" {}
variable "environment" {
  description = "Type of environment"
  type        = string
  default     = ""
}
variable "solution" {
  description = "Name of the solution"
  type        = string
  default     = ""
}

variable "resource_name" {}
variable "location_short" {}
variable "instance_number" {}

variable "common_tags" {
  description = "Common tags applied to all the resources created in this module"
  type        = map(string)
}

