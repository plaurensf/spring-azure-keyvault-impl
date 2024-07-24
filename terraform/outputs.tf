# outputs.tf contains all output blocks in alphabetical order

output "tf_container_registry_id" {
  value = azurerm_container_registry.tf_container_registry_dev.id
}