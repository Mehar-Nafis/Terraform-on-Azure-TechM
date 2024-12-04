* Create an Active Directory service principal account for authentication
```
az ad sp create-for-rbac --skip-assignment
```
<img width="947" alt="image" src="https://github.com/user-attachments/assets/076380f7-6585-4173-8568-5b3182f204ac">

* Replace the values in your terraform.tfvars file with your appId and password. 
* Configure kubectl
```
  az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
```
* To verify that your cluster's configuration, visit the Azure Portal's Kubernetes resource view
```
  az aks browse --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
```
