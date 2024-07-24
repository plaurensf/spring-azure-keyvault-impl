# backend.tf contains backend configuration. It maintains the state not local but in the cloud to share it with the rest of devs.

terraform {
  backend "azurerm" {
    resource_group_name = var.resource-group
    storage_account_name = "tfstoragestore"
    container_name = "tfstorestate"
    key = "terraform.tfstate"
  }
}