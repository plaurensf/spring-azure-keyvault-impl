data "azurerm_client_config" "current" {}

# Azure Container Registry
resource "azurerm_container_registry" "shop-container-registry" {
  location            = var.location
  name                = "shopcontainerregistry${var.environment}${var.location}"
  resource_group_name = var.resource-group
  sku                 = "Standard"
}

# Azure User Assigned Identity
resource "azurerm_user_assigned_identity" "secrets-managed-identity" {
  location            = var.location
  name                = "secrets-manage-identity-${local.resource_env_suffix}"
  resource_group_name = var.resource-group
}

#Azure Container Apps Environment
resource "azurerm_log_analytics_workspace" "inventory-analytics-workspace" {
  name                = "inventory-analytics-${local.resource_env_suffix}"
  location            = var.location
  resource_group_name = var.resource-group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "inventory-aca-environment" {
  name                       = "inventory-aca-environment-${local.resource_env_suffix}"
  location                   = var.location
  resource_group_name        = var.resource-group
  log_analytics_workspace_id = azurerm_log_analytics_workspace.inventory-analytics-workspace.id
}

#Azure KeyVault
resource "azurerm_key_vault" "shop-app-keyvault" {
  location            = var.location
  name                = "shop-app-kv-${local.resource_env_suffix}"
  resource_group_name = var.resource-group
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  access_policy {
    object_id = data.azurerm_client_config.current.object_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Get",
      "List",
      "Set"
    ]
  }
}

#Azure Container App
resource "azurerm_container_app" "inventory-app-service" {
  name                         = "inventory-app-${local.resource_env_suffix}"
  container_app_environment_id = azurerm_container_app_environment.inventory-aca-environment.id
  resource_group_name          = var.resource-group
  revision_mode                = "Single"

  template {
    container {
      name = "inventory-app-container"
      cpu = 0.25
      memory = "0.5Gi"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
    }
    max_replicas = 2
    min_replicas = 0
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.secrets-managed-identity.id]
  }

  secret {
    name     = "inventory-secret-app"
    value    = azurerm_key_vault.shop-app-keyvault.vault_uri
  }
}
