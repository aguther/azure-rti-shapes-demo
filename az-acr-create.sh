#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <REGISTRY_NAME>

# create registry
az acr create \
  --resource-group $1 \
  --location eastus2 \
  --name $2 \
  --sku Basic

# enable admin account
az acr update \
  --name $2 \
  --admin-enabled true

# docker login
az acr login \
  --name $2

# determine and print url of registry
echo "Docker registry url      = $(az acr list --resource-group $1 --query "[].{acrLoginServer:loginServer}" --output tsv)"

# print username of registry
echo "Docker registry user     = $2"

# determine and print password of registry
echo "Docker registry password = $(az acr credential show --name $2 --query "passwords[0].value" --output tsv)"
