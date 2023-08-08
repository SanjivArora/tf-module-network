Health Alliance Azure VNET Terraform Module
=================================================

Terraform module which creates an [Azure VNET](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) and [Azure Monitor Diagnostic Settings](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings?tabs=portal)

These types of Terraform resources are supported:

* [Azure VNET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
* [Azure Monitor Diagnostic Settings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

Features
--------

This module implements the following:

* Creates an Azure VNET named `"${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}"`
* Creates an Azure Monitor Diagnostic Settings named `"ds-${lower("${var.environment}-${var.solution}-${var.resource_name}-${var.location_short}-${var.instance_number}")}"`

Usage
-----

```hcl
module "default_vnet" {
  source                     = "git::https://dev.azure.com/NorthernRegion-DEV/az-terraform-modules/_git/tf-module-network/vnet"
  resource_group_name        = azurerm_resource_group.network_rg.name
  location                   = azurerm_resource_group.network_rg.location
  instance_number            = 1
  resource_name              = "vnet"
  common_tags                = local.common_tags
  location_short             = var.location_short
  environment                = var.environment
  solution                   = var.solution
  dns_servers                = var.dns_servers
  vnet_cidr_block            = var.default_vnet_cidr_block
  log_analytics_workspace_id = local.log_analytics_workspace_id
}
```
The information will be passed using a locals file:

```hcl
locals{
  vnet_cidr_block                     = ["10.16.0.0/23"]
  log_analytics_workspace_id          = ""
  default_common_tags = {
    cost-centre     = "12346"
    owner           = "michael.carr@healthalliance.co.nz"
    business-entity = "NR-Shared"
    environment     = var.environment
    security-zone   = "Manage"
    role            = "Infrastructure"
    application     = var.solution
    app-tier        = "Application"
    app-criticality = "Tier 2"
    support-team    = "Centric support team"
  }
}
```
Inputs
------

* `resource_name` - The vnet resource name being used in the naming convention
* `vnet_cidr_block` - cidr block range being used by the VNET
* `environment` - The name for the environment of where the resource group is being created (dev, acc, prd etc)
* `location` - The regional location of where the resource group will reside
* `resource_group_name` - The Resource Group name of where the VNET should be created
* `location_short` - The short name of the regional location used by the naming convention (ae, ase etc)
* `solution` - The network segement/Zone name of the solution (medical, enterprise, operational)
* `instance_number` - The instance number at the end of the resource that are being used in the naming convention
* `common_tags` - The list of common tags being used for tagging purposes
* `dns_servers` - The DNS server that will be used by this VNET
* `log_analytics_workspace_id` - The ID of the log analytics of where the diagnostic settings should be sent

Outputs
-------
* `name` - The name of the VNET
* `id` - The ID of the VNET
