variable "vnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    name           = string
    address_prefix = string
  }))
}

variable "peering_name" {
  type = string
}

variable "remote_vnet_id" {
  type = string
}