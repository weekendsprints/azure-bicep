# Static Web with Azure Bicep

This repository contains static web site sample, bicep template with deployment script and example of azure devops pipeline definition.

The end goal is to set the following process: 

![Deploy static website using Azure Bicep](images/azure-static-web-site-schema.png)

## Execution examples

```bash
# Check what is going to happen in case of succesfully deployed template.
az deployment sub what-if -l westeurope --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json
# Validate template's syntax
az deployment sub validate -l westeurope --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json
# Declarative deployment of Static web site resources.
az deployment sub create -l westeurope --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json

```

More examples can be seen in `pipelines/azure-pipelines.yml` ...