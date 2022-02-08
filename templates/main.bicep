targetScope = 'subscription'

param location string
param resourcePrefix string

var resourceGroupName = '${resourcePrefix}-rg'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

@description('Unique name of the solution. This must be between 3 and 24')
@minLength(3)
@maxLength(24) 
param storagename string = '${resourcePrefix}${uniqueString(resourcePrefix)}'

param storagecontainername string
param profileName string = '${resourcePrefix}${uniqueString(resourcePrefix)}'
param endpointName string = '${resourcePrefix}${uniqueString(resourcePrefix)}'
var storageAccountHostName = replace(replace(staticWeb.outputs.staticWebsiteUrl, 'https://', ''), '/', '')

@description('The path to the web index document.')
param indexDocumentPath string

@description('The path to the web error document.')
param errorDocument404Path string

module staticWeb 'modules/storage-with-static-web.bicep' = {
  name: 'staticWeb'
  scope: rg
  params: {
    location: location
    storagename: storagename
    containerName: storagecontainername
    profileName: profileName
    endpointName: endpointName
    indexDocumentPath: indexDocumentPath
    errorDocument404Path: errorDocument404Path
  }
}

module cdn 'modules/cdn.bicep' = {
  name: 'cdn'
  scope: rg
  params: {
    location: location
    profileName: profileName
    endpointName: endpointName
    storageAccountHostName: storageAccountHostName
  }
  
}
