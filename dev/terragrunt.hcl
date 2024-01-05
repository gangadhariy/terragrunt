locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  resource_group   = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  cluster-name     = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  vnet             = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  addr-space       = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))  
  subnet-name      = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  addr-prefix      = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  nat-name         = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  pub-ip           = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
  route-name       = read_terragrunt_config(find_in_parent_folders("azure-dev.hcl"))
# Extract out common variables for reuse
  env                = local.environment_vars.locals.environment
  azure_location     = local.region_vars.locals.azure_location
  resourcegroup_name = local.resource_group.locals.rg-name
  aks-name           = local.cluster-name.locals.cluster
  vn                 = local.vnet.locals.vn
  addr               = local.addr-space.locals.addr
  subnet             = local.subnet-name.locals.subnet
  prefix             = local.addr-prefix.locals.prefix
  nat                = local.nat-name.locals.nat
  pubip              = local.pub-ip.locals.pubip
  route              = local.route-name.locals.route
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
  location        = local.azure_location
  environment     = local.env
  resource_group_name  = local.resourcegroup_name
  cluster_name    = local.aks-name
  kubeconfig      =  "kubeconfig-dev"
  pool            =  "devpool"
  vn_name         =  local.vn
  addr_space      =  local.addr
  sub_name        =  local.subnet
  addr_prefix     =  local.prefix
  nat_name        =  local.nat
  pubip_name      =  local.pubip
  route_name      =  local.route
}
