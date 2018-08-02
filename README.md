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
./az-group-create.sh kubernetes
./az-acr-create.sh kubernetes registryKubernetes

# load images into registry (must already be loaded into local docker)
./az-acr-load-images.sh kubernetes registryKubernetes

# create k8s cluster
./az-aks-create.sh kubernetes kubernetes
./az-aks-add-acr.sh kubernetes registryKubernetes registry-kubernetes

# deploy helm chart for rti shapes demo
./helm-install-rti-shapes-demo.sh kubernetes kubernetes registry-kubernetes

# start rti shapes demo
./rtishapesdemo-start.sh kubernetes kubernetes
```
