#terraform.tf contains a single terraform block which defines your
# required_version and required_providers

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # provider version
      version = "3.109.0"
    }
  }

  # terraform version
  required_version = ">= 1.4.0"
}