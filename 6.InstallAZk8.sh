$RGNAME='azk8sdemo-RG'
az group create --name $RGNAME --location $LOCATION


$AKSNAME='azk8dsemo6aks'
az aks create --location $LOCATION --resource-group $RGNAME --name $AKSNAME --enable-addons monitoring --kubernetes-version $VERSION --generate-ssh-keys

# Retrieve the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --resource-group $RGNAME --name $AKSNAME --query "identityProfile.kubeletidentity.clientId" --output tsv)

# Retrieve the ACR registry resource id
ACR_ID=$(az acr show --name $ACRNAME --resource-group $RGNAME --query "id" --output tsv)

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

ACRNAME='az400m16acr'$RANDOM$RANDOM
az acr create --location $LOCATION --resource-group $RGNAME --name $ACRNAME --sku Standard

az acr show --name $ACRNAME --resource-group $RGNAME --query "loginServer" --output tsv

az aks get-credentials --resource-group $RGNAME --name $AKSNAME

 az aks scale --resource-group $RGNAME --name $AKSNAME --node-count 2

 kubectl get pod -o=custom-columns=NODE:.spec.nodeName,POD:.metadata.name

 az group list --query "[?starts_with(name,$RGNAME)].name" --output tsv

 az group list --query "[?starts_with(name,$RGNAME)].[name]" --output tsv | xargs -L1 bash -c 'az group delete --name $0 --no-wait --yes'