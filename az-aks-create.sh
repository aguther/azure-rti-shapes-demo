#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <CLUSTER_NAME>

# create kubernetes cluster
az aks create \
  --resource-group $1 \
  --location eastus2 \
  --name $2 \
  --node-vm-size Standard_DS1_v2 \
  --node-count 3 \
  --kubernetes-version 1.10.6 \
  --generate-ssh-keys \
  --disable-rbac

# install kubectl
#sudo az aks install-cli

# get credentials for kubectl
az aks get-credentials \
  --resource-group $1 \
  --name $2

# initialize helm
helm init

# create public ip
az network public-ip create \
  --resource-group $(az resource show --resource-group $1 --name $2 --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv) \
  --location eastus2 \
  --name $2 \
  --allocation-method static

# display public ip
echo "Public IP = $(az network public-ip show --name $2 --query ipAddress --output tsv --resource-group $(az resource show --resource-group $1 --name $2 --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv))"
