#!/usr/bin/env bash

# usage: <RESOURCE_GROUP> <CLUSTER_NAME>

# run redirection to access kubernetes dashboard
exec az aks browse --resource-group $1 --name $2 |& logger --tag az-aks-browse &
