[version]
	docker compose version

run the command inside the same dir as the yaml file

[create]
	docker compose create

[build]
	docker compose build

[start]
	start containers based on docker compose yaml
	[cases]
		if docker image using dockerfile, it will automatically build it
		if we made a changes
			changes will be applied if we remove the containers and recreated it (down), restart will not applied new changes

	docker compose start

[ps]
	show containers
	docker compose ps

[stop]
	stop running containers
	docker compose stop

[down]
	remove containers, networks and volumes
	for images must be manual deleted
	docker compose down

[ls]
	show all composes (projects) -- project name based on compose dir name
	docker compose ls

[merge]
	add new or update attributes from yaml_2 to yaml_1

	docker compose -f base.yaml -f prod.yaml create

