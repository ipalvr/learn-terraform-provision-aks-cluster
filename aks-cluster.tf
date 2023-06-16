#resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "WeibAKS-rg"
  location = "East US"

  tags = {
    Environment = "Demo Cluster Buile"
    yor_trace   = "b585d8b6-38c8-4ec3-b6dd-33e190514030"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  # checkov:skip=CKV_AZURE_117: ADD REASON
  # checkov:skip=CKV_AZURE_116: ADD REASON
  # checkov:skip=CKV_AZURE_115: ADD REASON
  # checkov:skip=CKV_AZURE_4: ADD REASON
  # checkov:skip=CKV_AZURE_6: ADD REASON
  # checkov:skip=CKV_AZURE_7: ADD REASON
  name                = "weib-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "weib-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "Demo"
    yor_trace   = "562cb116-1354-43e6-b708-5730b16aa2c3"
  }
}
