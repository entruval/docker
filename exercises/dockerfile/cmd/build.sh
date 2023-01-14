docker build -t entruval/cmd exercises/dockerfile/cmd

CMD will not printted on build logs, it is in container logs when started

use inspect if we want to see where the cmd in the image
docker image inspect entruval/cmd
	search for
	"Cmd": [
		"/bin/sh",
		"-c",
		"cat \"hello/world.txt\""
	]

docker container create --name cmd entruval/cmd

docker container start cmd

docker container logs cmd

