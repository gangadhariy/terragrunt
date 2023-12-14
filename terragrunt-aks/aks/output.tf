output "resource_group_name" {
  value = azurerm_kubernetes_cluster.default.resource_group_name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "location" {
  value = azurerm_kubernetes_cluster.default.location
}

#output "service_principal_id" {
#  value = azurerm_kubernetes_cluster.default.service_principal.client_id
#}

#output "service_principal_password" {
#  value = azurerm_kubernetes_cluster.default.service_principal.client_secret
#}

output "environment" {
  value = azurerm_kubernetes_cluster.default.tags.environment
}