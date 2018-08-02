#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <CLUSTER_NAME> <SECRET_NAME>

# get the url of the registry
REGISTRY_URL=$(az acr list --resource-group $1 --query "[].{acrLoginServer:loginServer}" --output tsv)
# get the name of the registry secret
REGISTRY_SECRET=$3
# get the public ip
PUBLIC_IP=$(az network public-ip show --name $2 --query ipAddress --output tsv --resource-group $(az resource show --resource-group $1 --name $2 --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv))

# start install of chart and set values
helm install ../helm-chart-rti-shapes-demo --set registry.url=$REGISTRY_URL,registry.pullSecret=$REGISTRY_SECRET,routingService.service.type=LoadBalancer,routingService.service.ip=$PUBLIC_IP
