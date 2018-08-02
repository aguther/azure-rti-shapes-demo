#!/usr/bin/env bash

# usage: <RESOURCE_GROUP>

# delete resource group
az group delete \
  --name $1
