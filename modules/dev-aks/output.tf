output "resource_group_name" {
  value = azurerm_kubernetes_cluster.dev.resource_group_name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.dev.name
}

output "location" {
  value = azurerm_kubernetes_cluster.dev.location
}


output "environment" {
  value = azurerm_kubernetes_cluster.dev.tags.environment
}


