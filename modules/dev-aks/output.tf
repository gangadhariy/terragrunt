output "resource_group_name" {
  value = azurerm_kubernetes_cluster.default.resource_group_name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "location" {
  value = azurerm_kubernetes_cluster.default.location
}


output "environment" {
  value = azurerm_kubernetes_cluster.dev.tags.environment
}


