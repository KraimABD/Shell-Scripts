#!/bin/bash
resourceGroup="NewResourceGroup"
location="eastus"

az group create --name $resourceGroup --location $location

az vm create \
  --resource-group $resourceGroup \
  --location $location \
  --name SampleVM \
  --image UbuntuLTS \
  --admin-username amessk \
  --generate-ssh-keys \
  --verbose
