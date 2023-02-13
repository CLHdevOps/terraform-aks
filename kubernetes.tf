data "azurerm_container_registry" "prod_acr" {
  provider            = azurerm.ent-shared-dev
  name                = "icriehre2acrprd"
  resource_group_name = "ic-riehr-e2-management-rg-prd"
}

data "azurerm_subnet" "aks" {
  name = "ic-riehr-e2-aks-apps-sub-__DeployToEnvironment__"
  virtual_network_name = "ic-riehr-e2-aks-apps-vn-__DeployToEnvironment__"
  resource_group_name = "ic-riehr-e2-aks-apps-rg-__DeployToEnvironment__"
}

module "akscluster" {
  source = "..\\..\\Terraform\\modules\\Azure.Kubernetes"

  resource_group_name     = "ic-riehr-e2-aks-apps-rg-__DeployToEnvironment__"
  aks_vnet_name           = "ic-riehr-e2-aks-apps-vn-__DeployToEnvironment__"
  cluster_name            = "ic-riehr-e2-aks-apps-__DeployToEnvironment__"
  location                = var.Location
  dns_prefix              = "appspool"
  private_cluster_enabled = true
  private_dns_zone_id     = "System"
  kubernetes_version      = "1.23.12"
  azure_policy_enabled    = true

  #kubernetes.node_pool
  node_pool_name                = "appspool"
  node_pool_count               = 2
  node_pool_vm_size             = "Standard_D4s_v3"
  node_pool_enable_auto_scaling = true
  node_pool_max_pods            = 40
  node_pool_os_disk_size_gb     = 128
  node_pool_max_count           = 15
  node_pool_min_count           = 2
  node_pool_zones               = ["1", "2"]
  kubernetes_subnet_id          = data.azurerm_subnet.aks.id
  node_pool_type                = "VirtualMachineScaleSets"

  #kubernetes.service_principal
  client_id     = "25441118-fc1c-45f3-97b8-6a97ed7be3e1"
  client_secret = "mZnrnre-tiA7_txTDj8VdTePa.f2a50VK7"

  #kubernetes.windows_profile
  windows_profile_admin_login    = "DevOpsAdmin"
  windows_profile_admin_password = "__SQLDbPassword__"
  auto_scaler_scan_interval      = "30s"

  #kubernetes.network_profile
  network_profile_plugin             = "azure"
  network_profile_mode               = "transparent"
  network_profile_docker_bridge_cidr = "172.17.0.1/16"
  network_profile_service_cidr       = "10.2.0.0/24"
  network_profile_dns_service_ip     = "10.2.0.10"

  #acr
  service_principal_id  = var.SPNAppId
  role_definition_name  = "AcrPull"
  container_registry_id = data.azurerm_container_registry.prod_acr.id

  nsgrules                          = var.Apps_VNet_Nsg_Rules
  load_balancer_resource_group_name = "mc_ic-riehr-e2-aks-apps-rg-__DeployToEnvironment___ic-riehr-e2-aks-apps-__DeployToEnvironment___eastus2"

  tags = module.set_tags.workspace_tags
}


#region VNetPeerings
