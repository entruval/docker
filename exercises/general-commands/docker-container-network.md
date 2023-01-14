
docker network create --driver bridge mongonetwork

docker container create --name mongodb --network mongonetwork --env MONGO_INITDB_ROOT_USERNAME=eko --env MONGO_INITDB_ROOT_PASSWORD=eko mongo:latest

docker image pull mongo-express:latest

--env ME_CONFIG_MONGODB_URL="user:password@container_name:container_port"
docker container create --name mongodbexpress --network mongonetwork --publish 8081:8081 --env ME_CONFIG_MONGODB_URL="mongodb://eko:eko@mongodb:27017/" mongo-express:latest

docker container start mongodb

docker container start mongodbexpress

open localhost:8081 in browser

docker network disconnect mongonetwork mongodb

docker network connect mongonetwork mongodb
