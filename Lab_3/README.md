#
# Lab 3 : déploiement et configuration d'Azure Kubernetes Service avec Terraform
#

-----------------------------------------------------------------------------------------------------

## Objectifs

Ceci est un ensemble de fichiers Terraform pour déployer un cluster Azure Kubernetes Cluster avec les options suivantes: 

- Les Nodes sont dispatchés dans plusieurs Availability Zones (AZ)
- Les Node pools sont configurés en mode autoscaling
- pool1 est le node pool system sous Linux  a linux (exécute les pods dans le namespace kube system pods)
- pool2 (optionnel) est un node pool Windows Server 2022 ou Linux avec une "taint"
- les node pool ont des Managed Identities 
- Choix possible de la SKU du Control Plane (Free or Paid)
- Les add-ons suivants : Azure Monitor

Les ressources déployées par ce code Terraform sont les suivantes :

- Un Azure Resource Group
- Un cluster Azure Kubernetes Services Cluster with 1 node pool (1 Virtual Machine ScaleSet) linux
- Un node pool Windows Server ou Linux (1 Virtual Machine ScaleSet) --> optionnel
- Un Azure Load Balancer Standard SKU
- Une Azure Public IP
- Un Virtual Network avec ses Subnets (subnet pour les pods AKS, de subnets pour AzureBastion,Azure Firewall, Azure Application Gateway
- Un Azure Log Analytics Workspace (used for Azure Monitor Container Insight)
- Azure Application Gateway + Application Gateway Ingress Controller AKS add-on --> optionnel
- An Azure Log Analytics Workspace (used for Azure Monitor Container Insight)

On Kubernetes, these Terraform files will :

- Deploy Grafana using Bitnami Helm Chart and exposed Grafana Dashboard using Ingress (and AGIC)
- Create a pod, a service and an ingress (the file associated is renamed in .old because of issue during first terraform plan) 

## Pré-requis sur le poste d'administration

- An Azure Subscription with enough privileges (create RG, AKS...)
- Azure CLI 2.37 or >: <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>
   And you need to activate features that are still in preview and add extension aks-preview to azure CLI (az extension add --name aks-preview)
- Terraform CLI 1.2.2 or > : <https://www.terraform.io/downloads.html>
- Helm CLI 3.9.0 or > : <https://helm.sh/docs/intro/install/> if you need to test Helm charts


## Préparation de l'environnement AVANT le déploiement avec Terraform

- Ouvrir une session Bash et se connecter à votre abonnement Azure

```bash
az login
```


## Déploiement du Cluster AKS

1. Ouvrir une session Bash et se connecter à votre abonnement Azure

```bash
az login
```

2. Editer le fichier __configuration.tfvars__ et compléter avec vos valeurs

3. Editer le fichier __1-versions.tf__ et modifier les paramètres si besoin

4- Visualiser et modifier si besoin le fichier __"3-vars.tf"__

5. Initialiser le déploiement terraform

```bash
terraform init
```

6. Planifier le déploiement terraform

```bash
terraform plan --var-file=myconfiguration.tfvars
```

6. Apply your terraform deployment

```bash
terraform apply --var-file=myconfiguration.tfvars
```


## Vérification du déploiement du cluster

Une fois le déploiement effectué, vérifier le cluster en utilisant le portail Azure ou mieux avec Azure CLI

```bash
az aks show --resource-group "<your-AKS-resource-group-name>" --name "<your-AKS-cluster-name>" -o jsonc
```

Récupérer votre kubeconfig:

```bash
az aks get-credentials --resource-group "<your-AKS-resource-group-name>" --name "<your-AKS-cluster-name>" --admin
```
