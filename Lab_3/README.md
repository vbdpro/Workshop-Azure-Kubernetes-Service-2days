#
# Lab 3 : déploiement et configuration d'Azure Kubernetes Service avec Terraform
#

-----------------------------------------------------------------------------------------------------

## Objectifs

Ceci est un ensemble de fichiers Terraform pour déployer un cluster Azure Kubernetes Cluster certaines options.

Les ressources déployées par ce code Terraform sont les suivantes :

- Un Azure Resource Group
- Un cluster Azure Kubernetes Services Cluster with 1 node pool (1 Virtual Machine ScaleSet) linux
- Un node pool Windows Server ou Linux (1 Virtual Machine ScaleSet) --> optionnel
- Un Azure Load Balancer Standard SKU
- Une Azure Public IP
- Un Virtual Network avec ses Subnets (subnet pour les pods AKS, de subnets pour AzureBastion,Azure Firewall, Azure Application Gateway
- Un Azure Log Analytics Workspace (used for Azure Monitor Container Insight)


## Pré-requis sur le poste d'administration

- An Azure Subscription with enough privileges (create RG, AKS...)
- Azure CLI 2.37 or >: <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>
   And you need to activate features that are still in preview and add extension aks-preview to azure CLI (az extension add --name aks-preview)
- Terraform CLI 1.2.2 or > : <https://www.terraform.io/downloads.html>
- Helm CLI 3.9.0 or > : <https://helm.sh/docs/intro/install/> if you need to test Helm charts


## Déploiement du Cluster AKS

1. Ouvrir une session Bash et se connecter à votre abonnement Azure

```bash
az login
```

2. Aller dans le répertoire Lab_3 et éditer le fichier __configuration.tfvars__ et compléter avec vos valeurs

3. Editer le fichier __1-versions.tf__ et modifier les paramètres si besoin (la version de terraform par exemple)

4- Visualiser et modifier si besoin le fichier __"3-vars.tf"__

5- Lire les autres fichiers .tf et essayer de comprendre le code fourni

6. Initialiser le déploiement terraform

```bash
terraform init
```

7. Planifier le déploiement terraform

```bash
terraform plan --var-file=myconfiguration.tfvars
```

8. Apply your terraform deployment

```bash
terraform apply --var-file=myconfiguration.tfvars
```

9- Attendre la fin du déploiement

## Vérification du déploiement du cluster

Une fois le déploiement effectué, vérifier le cluster en utilisant le portail Azure ou mieux avec Azure CLI

```bash
az aks show --resource-group "<your-AKS-resource-group-name>" --name "<your-AKS-cluster-name>" -o jsonc
```

Récupérer votre kubeconfig:

```bash
az aks get-credentials --resource-group "<your-AKS-resource-group-name>" --name "<your-AKS-cluster-name>" --admin
```

Créer un fichier k8s-namespace.tf dans le répertoire où sont les fichiers .tf

Copier / Coller le code suivant :

```shell
resource "kubernetes_namespace_v1" "Terra-namespace" {
  metadata {
    annotations = {
      name = "monnamespace"
    }

    labels = {
      usage = "test"
    }

    name = "monnamespace"
  }
}
```

Sauvegarder les modifications

Exécuter la commande 

```shell
terraform apply --var-file=myconfiguration.tfvars
```

Une fois le déploiement terminé, vérifier que le namespace a bien été créé :

```shell
kubectl get ns
```
