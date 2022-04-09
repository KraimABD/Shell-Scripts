#!/bin/bash
# Modify your sources list so that the Microsoft repository is registered, and the package manager can locate the Azure CLI package
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
sudo tee /etc/apt/sources.list.d/azure-cli.list

# Import the encryption key for the Microsoft Ubuntu repository. This will allow the package manager to verify that the Azure CLI package you install comes from Microsoft.
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Install the Azure CLI
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli

# Test
echo "Testing by showing the version"
az --version
