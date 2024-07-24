# providers.tf contains all provider blocks and configuration

provider "azurerm" {
  features {}
  skip_provider_registration = true
}