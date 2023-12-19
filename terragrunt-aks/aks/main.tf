resource "azurerm_kubernetes_cluster" "default" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.resource_group_name}-k8s"
  kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "akspool01"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.secret
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "var.environment"
  }
}
