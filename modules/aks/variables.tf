variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the AKS cluster will be created"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "cluster_name" {
  type        = string
  description = "The name of the AKS cluster"
}

variable "environment" {
  type        = string
  description = "The environment of the AKS cluster"
}

variable "pool" {
  type        = string
  description = "The name  of the AKS nodepool"
}

variable "kubeconfig" {
  type        = string
  description = "The name of the AKS cluster config file"
}
variable "vn_name" {
  type        = string
  description = "The name of the virtual network"

}

variable "addr_space" {
  type        = list(string)
  description = "adress spce of the virtual network"

}

variable "sub_name" {
  type        = string
  description = "name of the subnet"

}

variable "addr_prefix" {
  type        = list(string)
  description = "prefix of the subnet"

}

variable "nat_name" {
  type        = string
  description = "name of the nat gateway"

}

variable "pubip_name" {
  type        = string
  description = "name of the public ip"

}
variable "dns_ip" {
  type        = list(string)
  description = "name of the public ip"

}

variable "route_name" {
  type        = string
  description = "name of the route table"

}
