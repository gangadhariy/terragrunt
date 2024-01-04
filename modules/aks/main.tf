resource "azurerm_resource_group" "aks" {
   name  =  var.resource_group_name
   location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vn_name
  address_space       = var.addr_space
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.sub_name
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.addr_prefix
}

resource "azurerm_nat_gateway" "nat" {
  name                = var.nat_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  public_ip_address   = azurerm_public_ip.natip.id
}

resource "azurerm_public_ip" "natip" {
  name                = var.pubip_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

resource "azurerm_network_security_group" "sec-grp" {
  name                = var.sec_grp_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

resource "azurerm_route_table" "route" {
  name                = var.route_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
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
