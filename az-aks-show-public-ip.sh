#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <CLUSTER_NAME>

# display public ip
echo "Public IP = $(az network public-ip show --name $2 --query ipAddress --output tsv --resource-group $(az resource show --resource-group $1 --name $2 --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv))"
