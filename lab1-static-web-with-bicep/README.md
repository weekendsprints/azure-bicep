# Static Web with Azure Bicep

This repository contains *static web site sample*, *azure bicep template* with deployment script and example of *azure devops pipeline* definition.

The end goal is to set the following process: 

![Deploy static website using Azure Bicep](images/azure-static-web-site-schema.png)

## Azure Bicep

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fweekendsprints%2Fazure-bicep%2Fmaster%2Flab1-static-web-with-bicep%2Ftemplates%2Fmain.json)
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fweekendsprints%2Fazure-bicep%2Fmaster%2Flab1-static-web-with-bicep%2Ftemplates%2Fmain.json)

Example of execution: 

```bash

# IaC part

az deployment sub what-if -l westeurope --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json
az deployment sub validate -l westeurope --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json
az deployment sub create -l westeurope --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json

# Site content upload and CDN enpoint purge (invalidation)

## Upload files to storage (web-site content) from ./src folder and purge CDN cached content
az storage blob upload-batch --account-name $(storage) -s ./src -d '$web'
az cdn endpoint purge -g $(rg) -n $(cdnendpint) --profile-name $(cdnprofile) --no-wait --content-paths '/'

## Output with hostName of the endpoint
echo "Static website URL is  => `az cdn endpoint list -g $(rg) --profile-name $(cdnprofile) | jq -r ".[].hostName"`"

```

In order to build ARM out of Bicep use:

```bash
 bicep build main.bicep --outdir .
 ```


