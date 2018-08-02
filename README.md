# azure-rti-shapes-demo

## Dependencies

You will need the following repositories to use this example.

### github.com/aguther/rti-connext-dds-pro

This repository is needed to build RPM packages for RTI runtime and services.

### github.com/aguther/dds-examples

This repository is needed to build the docker images for
- Cloud Discovery Service
- Routing Service
- DDS Examples

### github.com/aguther/helm-chart-rti-shapes-demo

 This repository is needed to deploy the example to kubernetes

## Example how to use
```bash
# log into azure
az login

# create docker registry
./az-group-create.sh <resource_group_name>
./az-acr-create.sh <resource_group_name> <registry_name>

# load images into registry (must already be loaded into local docker)
./az-acr-load-images.sh <resource_group_name> <registry_name>

# create k8s cluster
./az-aks-create.sh <resource_group_name> <cluster_name>
./az-aks-add-acr.sh <resource_group_name> <registry_name> <registry_secret_name>

# deploy helm chart for rti shapes demo
./helm-install-rti-shapes-demo.sh <resource_group_name> <cluster_name> <registry_secret_name>

# start rti shapes demo
./rtishapesdemo-start.sh <resource_group_name> <cluster_name>
```
