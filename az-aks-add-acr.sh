#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <REGISTRY_NAME> <SECRET_NAME>

# add secret for authentication of docker registry
kubectl create secret docker-registry \
  $3 \
  --docker-server=$(az acr list --resource-group $1 --query "[].{acrLoginServer:loginServer}" --output tsv) \
  --docker-username=$2 \
  --docker-password=$(az acr credential show --name $2 --query "passwords[0].value" --output tsv)
