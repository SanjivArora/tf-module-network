variable "subnet_names" {}
variable "subnet_prefixes" {}
variable "resource_group_name" {}
variable "virtual_network_name" {}
variable "subnet_delegation" {
  description = "A map of subnet name to delegation block on the subnet"
  type        = map(map(any))
  default     = {}
}
variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}
variable "route_tables_ids" {
  description = "A map of subnet name to Route table ids"
  type        = map(string)
  default     = {}
}