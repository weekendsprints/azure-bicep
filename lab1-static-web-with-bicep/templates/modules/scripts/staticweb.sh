#/bin/bash -e

az storage blob service-properties update --account-name $StorageAccountName --static-website --404-document $ErrorDocument404Path --index-document $IndexDocumentPath