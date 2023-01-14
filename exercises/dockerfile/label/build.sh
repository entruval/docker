docker build -t entruval/label exercises/dockerfile/label

use inspect if we want to see where the label in the image
docker image inspect entruval/label
	search for
	"Labels": {
		"author": "henry",
		"purpose": "exercises",
		"state": "public"
	}

docker container create --name label entruval/label

docker container start label

docker container logs label

