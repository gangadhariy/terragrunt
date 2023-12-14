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

variable "appId" {
  type        = string
  description = "The client-id  to apply to the AKS cluster"
}

variable "secret" {
  type        = string
  description = "The password to apply to the AKS cluster"
}
