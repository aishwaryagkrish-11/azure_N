terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-001"
  location = var.location1
}

module "vnet_east" {
  source              = "./modules/networking"
  vnet_name           = "vnet-${var.environment}-${var.location1}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location1
  address_space       = ["10.0.0.0/16"]
  subnets = {
    subnet1 = {
      name           = "subnet-${var.environment}-${var.location1}-001"
      address_prefix = "10.0.1.0/24"
    }
    subnet2 = {
      name           = "subnet-${var.environment}-${var.location1}-002"
      address_prefix = "10.0.2.0/24"
    }
  }
  peering_name    = "peer-${var.location1}-to-${var.location2}"
  remote_vnet_id  = module.vnet_west.vnet_id
}

module "vnet_west" {
  source              = "./modules/networking"
  vnet_name           = "vnet-${var.environment}-${var.location2}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location2
  address_space       = ["172.16.0.0/16"]
  subnets = {
    subnet1 = {
      name           = "subnet-${var.environment}-${var.location2}-001"
      address_prefix = "172.16.1.0/24"
    }
    subnet2 = {
      name           = "subnet-${var.environment}-${var.location2}-002"
      address_prefix = "172.16.2.0/24"
    }
  }
  peering_name    = "peer-${var.location2}-to-${var.location1}"
  remote_vnet_id  = module.vnet_east.vnet_id
}

module "security" {
  source              = "./modules/security"
  nsg_name            = "nsg-${var.environment}-001"
  key_vault_name      = "kv-${var.environment}-001"
  location            = var.location1
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id          = data.azurerm_client_config.current.tenant_id
}

module "monitoring" {
  source              = "./modules/monitoring"
  law_name            = "law-${var.environment}-001"
  vault_name          = "rsv-${var.environment}-001"
  location            = var.location1
  resource_group_name = azurerm_resource_group.rg.name
}