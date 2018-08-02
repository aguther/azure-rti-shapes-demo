#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <CLUSTER_NAME>

# get the public ip
export AZURE_PUBLIC_IP=$(az network public-ip show --name $2 --query ipAddress --output tsv --resource-group $(az resource show --resource-group $1 --name $2 --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv))

# start rti shapes demo
exec rtishapesdemo -workspaceFile rtishapesdemo/AZURE_WORKSPACE.xml |& logger --tag rtishapesdemo &
