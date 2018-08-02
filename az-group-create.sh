#!/usr/bin/env bash

# usage: <RESOURCE_GROUP>

# create resource group
az group create \
  --name $1 \
  --location eastus2
