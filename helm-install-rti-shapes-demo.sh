#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <CLUSTER_NAME> <REGISTRY_NAME>

# get the url of the registry
REGISTRY_URL=$(az acr list --resource-group $1 --query "[].{acrLoginServer:loginServer}" --output tsv)
# get the username of the registry
REGISTRY_NAME=$3
# get the password of the registry
REGISTRY_PASSWORD=$(az acr credential show --name $3 --query "passwords[0].value" --output tsv)

# get the public ip
PUBLIC_IP=$(az network public-ip show --name $2 --query ipAddress --output tsv --resource-group $(az resource show --resource-group $1 --name $2 --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv))

# start install of chart and set values
helm install https://github.com/aguther/helm-charts/raw/master/rti-shapes-demo-1.6.0.tgz --namespace rti-shapes-demo --name rti-shapes-demo --set imageCredentials.name=$REGISTRY_NAME,imageCredentials.registry=$REGISTRY_URL,imageCredentials.username=$REGISTRY_NAME,imageCredentials.password=$REGISTRY_PASSWORD,routingService.service.type=LoadBalancer,routingService.service.ip=$PUBLIC_IP,persistenceService.enabled=True,persistenceService.storage.className=managed-premium
