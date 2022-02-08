# Azure Bicep 

This repository contains different material to practise with [Azure Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/). 

```bash
.
├── README.md
├── pipelines 
│   └── azure-pipelines.yml
├── src
│   ├── cake.png
│   ├── error.html
│   └── index.html
└── templates
    ├── main.bicep
    ├── modules
    │   ├── cdn.bicep
    │   ├── scripts
    │   │   └── staticweb.sh
    │   └── storage-with-static-web.bicep
    └── parameters.dev.json
```

## How to use it

You'll need Azure Subscription and Azure CLI.

Execution examples:

```bash
az deployment sub what-if -l $(location) --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json
az deployment sub validate -l $(location) --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json
az deployment sub create -l $(location) --template-file ./templates/main.bicep --parameters ./templates/parameters.dev.json

```