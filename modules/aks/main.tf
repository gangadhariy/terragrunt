resource "azurerm_resource_group" "aks" {
   name  =  var.resource_group_name
   location = var.location
}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${azurerm_resource_group.aks.name}-k8s"
  kubernetes_version  = "1.28.3"

  default_node_pool {
    name            = var.pool
    node_count      = 1
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }


  tags = {
    environment = var.environment
  }
}

resource "local_file" "kubeconfig" {
  content = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = var.kubeconfig
}
