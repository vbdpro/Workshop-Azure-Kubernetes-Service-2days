#  Resource Group Name for AKS Managed Service (Control Plane)
variable "resource_group" {
  type    = string
  default = "RG-AKSCluster"
}

#KeyVault Resource Group and KeyVaultName
# variable "keyvault_rg" {
#   type = string
#   default = "RG-AdminZone"
# }
# variable "keyvault_name" {
#   type = string
#   default = "keyvaultstan"
# }

variable "azure_region" {
  description = "Azure Region where to deploy resources. Caution the region must support Availability Zone"
  # To get names of Azure Region : az account list-locations
  # To check support of Availability Zone in the Azure Region see https://docs.microsoft.com/bs-latn-ba/azure/availability-zones/az-overview
  type    = string
  default = "eastus"
}

#
# Respect AKS naming rules !!!
# https://aka.ms/aks-naming-rules
#

# AKS Cluster name
variable "cluster_name" {
  type    = string
  default = "AKS-Stan1"
}

#AKS DNS name
# must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens.
# It must start with a letter and must end with a letter or a number.
variable "dns_name" {
  type    = string
  default = "aksstan1"
}

#(Optional) The upgrade channel for this Kubernetes Cluster. 
# Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none
variable "automatic_channel_upgrade" {
  type    = string
  default = "stable"
}



# sku of Azure managed K8S control plane
# Free = no SLA, SLO 99.5, Paid = SLA 99.95 with AS, 99.99 with AZ
variable "sku-controlplane" {
  type    = string
  default = "Free"
}

# Supported values are calico or azure
variable "networkpolicy_plugin" {
  type    = string
  default = "azure"
}

variable "enable-privatecluster" {
  type    = bool
  default = false
}

variable "enable-AzurePolicy" {
  type    = bool
  default = false
}

# supported values are : patch, rapid, stable
variable "automatic-channel-upgrade" {
  type = string
  default = "patch"
}

# Linux nodes admin user name
variable "admin_username" {
  type    = string
  default = "aksadmin"
}

# Windows nodes admin user name - Mandatory if you need at least one pool nodes with Windows nodes
variable "windows_admin_username" {
  description = "Windows Nodes admin user name"
  type        = string
  default     = "winadmin"
}

# Specify a valid kubernetes version
# Check before that the version is still available to deploy in Azure with the following command :
# az aks get-versions --location=nameofAzureRegion
variable "kubernetes_version" {
  description = "Version of Kubernetes to deploy"
  type        = string
  default     = "1.24.6"
}


#Default Agent Pool

variable "defaultpool-name" {
  description = "Name of cluster default linux nodepool"
  type        = string
  default     = "pool1"
}

variable "defaultpool-nodecount" {
  description = "Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100"
  type        = number
  default     = "1"
}

variable "defaultpool-vmsize" {
  description = "Size of VM"
  # check if the choosen size is available in Azure region you selected : az vm list-usage --location NAMEOFAZUREREGION -o table
  # az vm list-skus -l NAMEOFAZUREREGION
  type    = string
  default = "Standard_D2s_v5"
}

variable "defaultpool-ostype" {
  description = "can be linux or windows"
  type        = string
  default     = "linux"
}

variable "defaultpool-osdisksizegb" {
  description = "Size in GB of node OS disk"
  type        = number
  default     = "32"
}

variable "defaultpool-type" {
  description = "Possible values are AvailabilitySet and VirtualMachineScaleSets"
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "defaultpool-maxpods" {
  description = "number max of pods per node. can be between 30 to 250 on Advanced Network deployment"
  type        = number
  default     = "100"
}

variable "defaultpool-availabilityzones" {
  description = "availability zones of the region" # example : [1, 2, 3]"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "defaultpool-enableautoscaling" {
  description = "use this parameter if you want an AKS Cluster with Nodes autoscaling."
  # Need also min_count and max_count parameters
  type    = bool
  default = true
}

variable "defaultpool-mincount" {
  description = "number min of nodes in pool. can be between 1 to 99"
  type        = number
  default     = "1"
}

variable "defaultpool-maxcount" {
  description = "number max of nodes in pool. can be between 2 to 99"
  type        = number
  default     = "3"
}

variable "defaultpool-securitypolicy" {
  type    = bool
  default = false
}

variable "windowspool-name" {
  description = "Name of cluster windows nodepool"
  type        = string
  default     = "pool2"
}

variable "windowspool-nodecount" {
  description = "Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100"
  type        = number
  default     = "1"
}

variable "windowspool-vmsize" {
  description = "Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "windowspool-ostype" {
  description = "can be Linux or Windows"
  type        = string
  default     = "Windows"
}

variable "windowspool-osdisksizegb" {
  description = "Size in GB of node OS disk"
  type        = number
  default     = "128"
}

variable "windowspool-type" {
  description = "Possible values are AvailabilitySet and VirtualMachineScaleSets"
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "winpool-maxpods" {
  description = "number max of pods per node. can be between 30 to 250 on Advanced Network deployment"
  type        = number
  default     = "30" # cf. https://docs.microsoft.com/en-us/azure/aks/windows-node-limitations#can-i-change-the-max--of-pods-per-node
}

variable "winpool-availabilityzones" {
  description = "availability zones of the region" # example : [1, 2, 3]"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "winpool-enableautoscaling" {
  description = "use this parameter if you want an AKS Cluster with Nodes autoscaling."
  # Need also min_count and max_count parameters
  type    = bool
  default = true
}

variable "winpool-mincount" {
  description = "number min of nodes in pool. can be between 1 to 99"
  type        = number
  default     = "1"
}

variable "winpool-maxcount" {
  description = "number max of nodes in pool. can be between 2 to 99"
  type        = number
  default     = "3"
}

variable "winpool-nodetaints" {
  description = "A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule)"
  # cf. https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  # https://kubernetes.io/docs/setup/production-environment/windows/user-guide-windows-containers/
  type    = list(string)
  default = ["os=windows:NoSchedule"]
}


variable "aks_vnet_name" {
    type = string
    default = "aksvnetstan22"
}


# Variable to define the name of Log Analytics Workspace (used by Azure Monitor Logs)
variable "LogsWorkspaceName" {
  type    = string
  default = "AKS-Logsstan"
}

# Variable to choose SKU 
# Possible values : Free PerGB2018 PerNode Premium Standalone Standard CapacityReservation Unlimited
# Standalone = Pricing per Gb, PerNode = OMS licence 
# More info : https://azure.microsoft.com/en-us/pricing/details/log-analytics/
variable "LogsWorkspaceSKU" {
  type    = string
  default = "PerGB2018"
}

# Variable pour definir le nb de jours de rétention du workspaceOMS (Azure Logs Analytics)
# Possible values : 30 to 730
variable "LogsworkspaceDaysOfRetention" {
  type    = string
  default = "30"
}



# variable "a-record-dns-ingress" {
#     type = string
#     default = "demoingress1"
# }

# variable "dns-zone-name-for-ingress" {
#     type = string
#     default = "standemo.com"
# }

# variable "rg-name-dns-zone-for-ingress" {
#     type = string
#     default = "rg-azuredns"
# }


