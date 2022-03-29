# Step 1 - Start minikube for local deployment while pointing to Docker
minikube status

#Step 2 - start minikube if it is not started
minikube start

#step 3 run below command to point minikube docker and rebuild your image
& minikube -p minikube docker-env | Invoke-Expression
#Step 4 - Rebuild your image in minikube docker
docker build -t webappimage:v1 .

minikube service <service-name> #assign public IP to survice type load balancer
