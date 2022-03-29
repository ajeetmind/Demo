


#Step 1 - Build our web app first and test it prior to putting it in a container
dotnet build ./webapp
dotnet run --project ./webapp #Open a new terminal to test.
curl http://localhost:5000


#Step 2 - Let's publish a local build...this is what will be copied into the container
dotnet publish -c Release ./webapp


#Step 3 - Time to build the container and tag it...the build is defined in the Dockerfile
docker build -t webappimage:v1 .





#Step 4 - Run the container locally and test it out
docker run --name webapp --publish 8080:80 --detach webappimage:v1
curl http://localhost:8080


#Delete the running webapp container
docker stop webapp
docker rm webapp


#The image is still here.
docker image ls webappimage:v1
