variable "location1" {
  description = "Primary location"
  default     = "eastus"
}

variable "location2" {
  description = "Secondary location"
  default     = "westus"
}

variable "environment" {
  description = "Environment name"
  default     = "prod"
}

variable "admin_username" {
  description = "VM admin username"
  default     = "adminuser"
}

variable "admin_password" {
  description = "VM admin password"
  sensitive   = true
}