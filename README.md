# Quick Terraform + AWS Kubernetes Service (AKS) demo

## Getting started

Terraform requires some information on how you wish to authenticate. You need to create some kind of variables file under terraform folder, for example:

myname.auto.tfvars

In this file, give values for at least three variables defined in variables.tf:

aws_profile = "my-aws-profile-name"
aws_shared_credentials_file = "~/.aws/credentials"
aws_region = "eu-west-1"

Or anything to your own likings.


## Connect to Kubernetes cluster

Note: Provided example uses some preconfigured values in output.tf that depend on your particular environment. Namely reference to aws cli profile, which you probably need to change.


```
cd terraform

echo $(terraform output kubeconfig) > ~/.kube/eksconfig

export KUBECONFIG=~/.kube/eksconfig

kubectl version

kubectl get componentstatus
```


## Authorize worker nodes

Get the config from terraform output, and save it to a yaml file:

(cd terraform && terraform output config-map > ../config-map-aws-auth.yaml)
Apply the config map to EKS:

kubectl apply -f config-map-aws-auth.yaml
You can verify the worker nodes are joining the cluster

kubectl get nodes --watch

## Still todo

There are some reports that some resource tags are required by terraform aws eks provider.

"NOTE: The usage of the specific kubernetes.io/cluster/* resource tags below are required for EKS and Kubernetes to discover and manage networking resources."

These tags are not currently in place. This might require some extra work. So far haven't had issues with these, so it might be we only need these when we actually deploy something in cluster. Which brings to next point:

Add examples here on how to actually build and deploy a docker image to K8s cluster. Fix tags while at it, if needed.


## Misc Linx

https://medium.com/high-cloud/kubernetes-cluster-in-aws-with-terraform-1-b8e8c158581

https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/eks-getting-started
