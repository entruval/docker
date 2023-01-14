docker build -t entruval/add exercises/dockerfile/add

docker container create --name add entruval/add

docker container start add

docker container logs add

