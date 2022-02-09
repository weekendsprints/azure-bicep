# Azure Resource Governance with Bicep

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