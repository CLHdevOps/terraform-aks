variable "resource_group_name" {
  default     = ""
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}

variable "aks_vnet_name" {
  type        = string
  default     = ""
  description = "The name of the Virutal Network created for the Kubernetes Cluster."
}

variable "load_balancer_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource Group where the Kubernetes Cluster Load Balancer will be created"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  default     = ""
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created"
}

variable "dns_prefix" {
  type        = string
  default     = ""
  description = "(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
}

variable "private_cluster_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
}

variable "private_dns_zone_id" {
  type        = string
  default     = "System"
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
}

variable "kubernetes_version" {
  type        = string
  default     = "1.23.5"
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case. "
}

variable "azure_policy_enabled" {
  type        = string
  default     = ""
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service"
}

variable "node_pool_name" {
  type        = string
  default     = ""
  description = "(Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
}

variable "node_pool_count" {
  type        = number
  default     = 2
  description = "(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count."
}

variable "node_pool_vm_size" {
  type        = string
  default     = ""
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created."
}

variable "node_pool_enable_auto_scaling" {
  type        = bool
  default     = false
  description = "(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false."
}

variable "node_pool_max_pods" {
  type        = number
  default     = 40
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
}

variable "node_pool_os_disk_size_gb" {
  type        = string
  default     = ""
  description = "(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.)"
}

variable "node_pool_max_count" {
  type        = number
  default     = 15
  description = "(Required) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
}

variable "node_pool_min_count" {
  type        = number
  default     = 2
  description = "(Required) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
}

variable "node_pool_zones" {
  type        = list(string)
  default     = []
  description = "(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created."
}

variable "kubernetes_subnet_id" {
  type        = string
  default     = ""
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
}

variable "node_pool_type" {
  type        = string
  default     = "VirtualMachineScaleSets"
  description = "(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets."
}

variable "client_id" {
  type        = string
  default     = ""
  description = "(Required) The Client ID for the Service Principal."
}

variable "client_secret" {
  type        = string
  default     = ""
  description = "(Required) The Client Secret for the Service Principal."
}

variable "windows_profile_admin_login" {
  type        = string
  default     = ""
  description = "(Required) The Admin Username for Windows VMs."
}

variable "windows_profile_admin_password" {
  type        = string
  default     = ""
  description = "(Required) The Admin Password for Windows VMs. Length must be between 14 and 123 characters."
}

variable "auto_scaler_scan_interval" {
  type        = string
  default     = "10s"
  description = "How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to 10s."
}

variable "network_profile_plugin" {
  type        = string
  default     = "azure"
  description = "(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
}

variable "network_profile_mode" {
  type        = string
  default     = "transparent"
  description = "(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created."
}

variable "network_profile_docker_bridge_cidr" {
  type        = string
  default     = ""
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
}

variable "network_profile_service_cidr" {
  type        = string
  default     = ""
  description = "(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
}

variable "network_profile_dns_service_ip" {
  type        = string
  default     = ""
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
}

variable "service_principal_id" {
  type        = string
  default     = ""
  description = "Service Principal required to grant access to the ACR"
}

variable "role_definition_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with role_definition_id."
}

variable "container_registry_id" {
  type        = string
  default     = ""
  description = "ACR container id to which access will be given"
}

variable "nsgrules" {
  description = "The list of nsg rules"
  type = map(object({
    # (Required) The name of the security rule.
    name = string

    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
    priority = number

    # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
    direction = string

    # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
    access = string

    #  (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
    protocol = string

    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
    source_port_range = string

    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
    destination_port_range = string

    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
    source_address_prefix = string

    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
    destination_address_prefix = string
  }))
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
