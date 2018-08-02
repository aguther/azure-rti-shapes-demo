#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <REGISTRY_NAME>

# determine and print url of registry
echo "Docker registry url      = $(az acr list --resource-group $1 --query "[].{acrLoginServer:loginServer}" --output tsv)"

# print username of registry
echo "Docker registry user     = $2"

# determine and print password of registry
echo "Docker registry password = $(az acr credential show --name $2 --query "passwords[0].value" --output tsv)"
