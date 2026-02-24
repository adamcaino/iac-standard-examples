variable "name" {
  type        = string
  default     = "app"
  description = "name of the app"
}

variable "env" {
  type        = string
  default     = "prod"
  description = "environment"
}

variable "loc" {
  type        = string
  default     = "uksouth"
  description = "location for resources"
}

variable "admin_password_windows" {
  type        = string
  sensitive   = true
  default     = "P@ssw0rd123!SomethingRandom"
  description = "the password for windows admin"
}

variable "admin_password_linux" {
  type        = string
  sensitive   = true
  default     = "P@ssw0rd456!AnotherRandom"
  description = "the password for linux admin"
}
