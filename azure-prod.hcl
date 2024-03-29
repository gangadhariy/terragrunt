locals {
  environment    =  "prod"
  azure_location = "eastus"
  rg-name        = "aks-prod-rg"
  cluster        =  "prod-aks"
  vn             =  "prodvn"
  addr           =  ["10.3.0.0/16"]
  subnet         =  "prodsub"
  prefix         =  ["10.3.1.0/24"]
  nat            =  "pubnat"
  pubip          =  "prodsub"
  route          =  "prodroute"
  dns            =  ["10.3.2.10"]
  svc-cidr       =  ["10.3.2.0/24"] 
}
