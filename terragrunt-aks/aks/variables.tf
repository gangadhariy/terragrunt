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

