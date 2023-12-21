output "resource_group_name" {
  value = azurerm_kubernetes_cluster.prod.resource_group_name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.prod.name
}

output "location" {
  value = azurerm_kubernetes_cluster.prod.location
}

output "environment" {
  value = azurerm_kubernetes_cluster.prod.tags.environment
}
