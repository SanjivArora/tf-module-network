variable "resource_group_name" {}
variable "location" {}
variable "environment" {}
variable "solution" {}
variable "resource_name" {}
variable "location_short" {}
variable "instance_number" {}
variable "common_tags" {}

variable "disable_bgp_route_propagation" {
  default = null
}


variable "routes" {
  type = list(object({
    name                       = string
    address_prefix             = string
    next_hop_type              = string
    next_hop_in_ip_address     = string
  }))
}
