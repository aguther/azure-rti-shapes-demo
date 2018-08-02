#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <REGISTRY_NAME>

function docker_tag_push_image {
  docker tag $2 $1/$2
  docker push $1/$2
}

# docker login
az acr login --name $2

# determine registry url
DOCKER_REGISTRY_URL=$(az acr list --resource-group $1 --query "[].{acrLoginServer:loginServer}" --output tsv)

# dds-examples
docker_tag_push_image $DOCKER_REGISTRY_URL dds-examples:latest

# rti-cloud-discovery-service
docker_tag_push_image $DOCKER_REGISTRY_URL rti-cloud-discovery-service:5.3.1

# rti-routing-service
docker_tag_push_image $DOCKER_REGISTRY_URL rti-routing-service:5.3.1
