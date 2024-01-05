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

resource "azurerm_public_ip" "natip" {
  name                = var.pubip_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

resource "azurerm_nat_gateway" "nat" {
  name                = var.nat_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  public_ip_address   = azurerm_public_ip.natip.id
}

resource "azurerm_route_table" "route" {
  name                = var.route_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  route {
    name           = "internet-route"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}
resource "azurerm_subnet_association" "public_subnet_association" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.route.id
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
network_profile {
    network_plugin = "azure"
    
    # Specify the subnets for AKS nodes
    service_cidr     = azurerm_subnet.subnet.address_prefixes[0]  # Use the subnet address space for services
    dns_service_ip   = "10.2.7.10"  # Specify a DNS service IP within the subnet
    docker_bridge_cidr = "172.17.0.1/16"

    load_balancer_sku = "standard"

    outbound_type = "loadBalancer"
  }
resource "local_file" "kubeconfig" {
  content = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = var.kubeconfig
}

