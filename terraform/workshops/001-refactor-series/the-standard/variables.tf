variable "workload_name" {
  type        = string
  default     = "app"
  description = "The name of the workload to deploy."
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "The environment the workload will be deployed into. E.g., dev, test, prod."
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "The Azure region to deploy resources into."
}

variable "admin_password_windows" {
  type        = string
  sensitive   = true
  description = "The password for Windows admin VM."
}

variable "admin_password_linux" {
  type        = string
  sensitive   = true
  description = "The password for Linux admin VM."
}
