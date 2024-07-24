# variables.tf contains all variables blocks in alphabetical order.

variable "resource-group" {
  description = "Resource group in which all the resources will be created"
  type = string
  default = "rg-pierrelaurens-training"
}

variable "location" {
  description = "Azure region which all resources will be created"
  type = string
  default = "eastus"
}

variable "environment" {
  description = "Environment in which resources will be created"
  type = string
  default = "dev"
}