output "resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "location" {
  value = azurerm_kubernetes_cluster.aks.location
}


output "environment" {
  value = azurerm_kubernetes_cluster.aks.tags.environment
}


