#!/bin/bash
echo "Provisioning environments..."

RESOURCE_GROUP="TeamBlue-RG"
LOCATION="northeurope"
TS_RG="WeekendSprints-TemplateSpec-RG"
TS_NAME="WeekendSprints-TemplateSpec-ACR"
VERSION="1.0.0"

RGP=$(az group create -l $LOCATION -n $RESOURCE_GROUP)
echo "Resource group $RESOURCE_GROUP has been created/updated"

ACR_TS_ID=$(az ts show --resource-group $TS_RG --name $TS_NAME --version $VERSION --query 'id' -o json)

az deployment group what-if \
  --resource-group $RESOURCE_GROUP \
  --template-spec $ACR_TS_ID \
  --parameters "./parameters-team-blue.json"

az deployment group validate \
  --resource-group $RESOURCE_GROUP \
  --template-spec $ACR_TS_ID \
  --parameters "./parameters-team-blue.json"

az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-spec $ACR_TS_ID \
  --parameters "./parameters-team-blue.json"