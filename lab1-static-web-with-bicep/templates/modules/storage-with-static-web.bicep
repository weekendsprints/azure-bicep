param location string
param storagename string
param containerName string
param profileName string
param endpointName string
param indexDocumentPath string
param errorDocument404Path string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storagename
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = {
  name: '${storageaccount.name}/default/${containerName}'
}

resource contributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription()
  // This is the Storage Account Contributor role, which is the minimum role permission we can give. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#:~:text=17d1049b-9a84-46fb-8f53-869881c3d3ab
  name: '17d1049b-9a84-46fb-8f53-869881c3d3ab'
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'DeploymentScript'
  location: location
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: storageaccount
  name: guid(resourceGroup().id, managedIdentity.id, contributorRoleDefinition.id)
  properties: {
    roleDefinitionId: contributorRoleDefinition.id
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

resource symbolicname 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'staticwebenable'
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  dependsOn: [
    // we need to ensure we wait for the role assignment to be deployed before trying to access the storage account
    roleAssignment
  ]
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.30.0'
    cleanupPreference: 'Always'
    retentionInterval: 'PT4H'
    environmentVariables: [
      {
        name: 'profileName'
        value: profileName
      }
      {
        name: 'endpointName'
        value: endpointName
      }
      {
        name: 'ResourceGroupName'
        value: resourceGroup().name
      }
      {
        name: 'StorageAccountName'
        value: storageaccount.name
      }
      {
        name: 'IndexDocumentPath'
        value: indexDocumentPath
      }
      {
        name: 'ErrorDocument404Path'
        value: errorDocument404Path
      }
    ]
    scriptContent: loadTextContent('./scripts/staticweb.sh')
  }
}

output staticWebsiteUrl string = storageaccount.properties.primaryEndpoints.web
output storageaccount string = storageaccount.name
