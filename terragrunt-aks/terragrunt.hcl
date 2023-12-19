locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("azure.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("azure.hcl"))
  resource_group   = read_terragrunt_config(find_in_parent_folders("azure.hcl"))
  clientid         = read_terragrunt_config(find_in_parent_folders("creds.hcl"))
  clientpass       = read_terragrunt_config(find_in_parent_folders("creds.hcl"))
  tenant           = local.tenant-id.locals.tenant

  # Extract out common variables for reuse
  env                = local.environment_vars.locals.environment
  azure_location     = local.region_vars.locals.azure_location
  resourcegroup_name = local.resource_group.locals.rg-name 
  appId              = local.clientid.locals.clientid
  password           = local.password.locals.secret
  tenant             = local.tenant-id.locals.tenant
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../aks"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  node_count      = 1
  vm_size         = "Standard_D2_v2"
  os_disk_size_gb = 50
  location        = local.azure_location
  environment     = local.env
  resource_group_name  = local.resourcegroup_name
  appId           = local.clientid
  secret          = local.clientpass
  tenant          = local.tenant

}
