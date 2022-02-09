#!/bin/bash

export TEMPLATE_SPEC="WeekendSprints-TemplateSpec-ACR"
export TEMPLATE_SPEC_DISPLAY_NAME="Weekend Sprints Template Spec ACR"
export TEMPLATE_SPEC_DESCRIPTION="Weekends Sprints Template Spec ACR Basic tier"
export RESOURCE_GROUP="WeekendSprints-TemplateSpec-RG"
export LOCATION="westeurope"
export VERSION="1.0.0"

echo "Deploying template spec to ... "
echo "Resource group:   $RESOURCE_GROUP"
echo "Location:         $LOCATION"
echo "Version:          $VERSION"

az group create -n $RESOURCE_GROUP -l $LOCATION

echo "Resource group $RESOURCE_GROUP has been created/updated"

az ts create \
    --name $TEMPLATE_SPEC \
    --display-name "$TEMPLATE_SPEC_DISPLAY_NAME" \
    --description "$TEMPLATE_SPEC_DESCRIPTION" \
    --version $VERSION \
    --tags BU=Finance Environment=Production \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --template-file "./main.bicep" \
    --yes \
    --query 'id' -o json