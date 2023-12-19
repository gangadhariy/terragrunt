
# Backend configuration for remote state management
remote_state {
  backend = "azurerm"  # Use Azure Storage as the backend
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name   = "Cluster-02-rg"
    storage_account_name  = "gklstorageaccount"
    container_name        = "gklcontaine"
    key                   = "${path_relative_to_include()}/terraform.tfstate"
  }
}
# Provider configuration for shared providers
generate "provider" {
  path      = "provider.tf"  # Relative path to generated provider configuration
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features = {}
}
EOF
}


