# Azure Resource Governance with Bicep

This repository folder contains material for the article - [Azure resource governance with project Bicep and Template Specs](https://erudinsky.com/2022/01/14/azure-resource-governance-with-project-bicep-and-template-specs/)

This folder includes 

```bash 
.
├── README.md
├── consumer-team-blue
│   ├── parameters-team-blue.json
│   └── provision.sh
├── template-spec-arm
└── template-spec-bicep
    ├── deploy-templates.sh
    └── main.bicep
```

## Example of execution

* Run `./template-spec-bicep/deploy-templates.sh` to provision template spec of ACR
* Run `./consumer-team-blue/provision.sh` to consume template spec to provision new instance of ACR (`./consumer-team-blue/parameters-team-blue.json` is to define params like *acrName* and *acrSku*)

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fweekendsprints%2Fazure-bicep%2Fmaster%2Flab2-azure-bicep-template-spec%2Ftemplate-spec-arm%2Fmain.json)
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fweekendsprints%2Fazure-bicep%2Fmaster%2Flab2-azure-bicep-template-spec%2Ftemplate-spec-arm%2Fmain.json)
