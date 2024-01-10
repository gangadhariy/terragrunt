locals  {
  environment    =  "dev"
  azure_location =  "eastus"
  rg-name        =  "aks-dev-rg"
  cluster        =  "dev-aks"
  vn             =  "devvn"
  addr           =  ["10.2.0.0/16"]
  subnet         =  "devsub"
  prefix         =  ["10.2.1.0/24"]
  nat            =  "devnat"
  pubip          =  "devsub"
  route          =  "devroute"
  dns            =  ["10.2.2.10"]
  svc-cidr       =  ["10.2.2.0/24"] 
}
