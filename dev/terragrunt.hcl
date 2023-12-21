locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  resource_group   = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  cluster-name     = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  # Extract out common variables for reuse
  env                = local.environment_vars.locals.environment
  azure_location     = local.region_vars.locals.azure_location
  resourcegroup_name = local.resource_group.locals.rg-name
  aks-name           = local.cluster-name.locals.cluster
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../modules/aks"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  node_count      = 1
  vm_size         = "Standard_D2_v2"
  location        = local.azure_location
  environment     = local.env
  resource_group_name  = local.resourcegroup_name
  cluster_name    = local.aks-name
  kubeconfig      =  "kubeconfig-dev"
  pool            =  "devpool"

}
