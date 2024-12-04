## Capstone-3: Provisioning Azure Kubernetes Service (AKS) Cluster with Terraform

### Problem Statement
You are part of a cloud infrastructure team tasked with provisioning an Azure Kubernetes Service (AKS) cluster using Terraform. 
The AKS cluster should be deployed on your default Virtual Private Cloud (VPC) with two nodes. 
After deployment, you should be able to access the Kubernetes dashboard and manage the cluster with kubectl. 
The solution must be repeatable and adhere to best practices in infrastructure as code.

#### Requirements

#### Inputs
* resource_group_name (type: string) - Name of the resource group where the AKS cluster will be deployed.
* location (type: string, default: "eastus") - Azure region for deployment.
* aks_cluster_name (type: string, default: "aks-cluster-terraform") - Name of the Azure Kubernetes Service cluster.
* node_count (type: number, default: 2) - Number of nodes for the AKS cluster.
* vm_size (type: string, default: "Standard_D2_v2") - Virtual machine size for the AKS nodes.
* os_disk_size_gb (type: number, default: 30) - OS disk size for the AKS node pool.
* app_id (type: string) - Application ID for service principal authentication.
* app_secret (type: string) - Password for the service principal.

#### Resources
* Azure Resource Group: Create an Azure resource group to contain the AKS cluster and associated resources.
* Azure Kubernetes Service Cluster - Provision an AKS cluster with the following configurations:
    * Kubernetes version: "1.26.3"
    * Node pool with 2 nodes and the specified VM size.
    * OS disk size: 30 GB.
    * Role-based access control (RBAC) enabled.
    * Service principal authentication for AKS.
* Active Directory Service Principal: Create a service principal for Terraform to authenticate and provision resources in Azure.

#### Outputs:

* kubernetes_cluster_name (type: string) - Name of the provisioned AKS cluster.
* resource_group_name (type: string) - Name of the resource group.
* kube_config_file (type: string) - Path to the kubectl configuration file for accessing the AKS cluster.

#### Validation & Cleanup
* Validate by running kubectl get nodes to ensure the AKS cluster is up and running.
* Access the Kubernetes Dashboard through the Azure Portal for monitoring and management.
* Test connectivity by deploying a sample application on the cluster.
* Ensure clean resource teardown by running terraform destroy to delete the AKS cluster and all associated resources.





