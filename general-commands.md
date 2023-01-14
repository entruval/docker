[get_image]
	docker pull image_name

[run]
	docker run -[flag][flag] image_id shell
	docker run -dit image_id bin/bash
	[flag]
		-d detach
		-i interactive
		-t connect I/O stream / terminal
		-p publish port
			system_port:container_port
			80:80
			system_port is our machine port
			container_port is docker container port
			we expose container_port using system_port, so we can give command to system_port that will be send to container from container_port
			we can define multiple system_port to a container
			-p 80:80 -p 81:81 -p 82:82
		-e environment variable
			-e db_username=root -e db_password="password 1" -- use " if any white space
		--name set name
		--memory set container memory
			-m 100b (bytes)
			-m 100k (kilo bytes)
			-m 100m (mega bytes)
			-m 100g (giga bytes)
		--cpus set container core
			--cpus 1.5 -- 1 core dan 0.5 core
			--cpus 0.1 -- 0.1 core
		--network - connect to a network

[inspect]
	docker inspect image | container | volume | network

[prune]
	clean unused image | container | volume | network
	docker container prune
	docker image prune
	docker volume prune
	docker network prune
	docker system prune (all)

[stats]
	docker stats container_id

[attach]
	1. docker exec -ti container_id bash
			-- attach without destroy the container when exit
	2. using nsenter
		1. docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
		2. inspect targeted container
		3. get container pid
		4. nsenter –m –u –n –p –i –t container_PID shell
			-- nsenter –m –u –n –p –i –t 2978 /bin/bash
			-- [flags]
				- u Uts namespace
				- m mount namespace
				- n network namespace
				- p process namespace
				- i interactive mode
				- t connect I/O stream

[pause]
	docker pause container_id

[unpause]
	docker unpause container_id

[kill]
	docker kill container_id

[stop]
	docker stop container_id

[list]
	docker ps
		-- active only
	docker ps -a
		-- stopped / exited status included
	docker images

[build]
	docker flags path | url | -
	docker -flags value .
		- docker -t tag -f path_to_file .
		- docker -t server -f ubuntu.dockerfile .
		https://docs.docker.com/engine/reference/commandline/build/#options

[scan]
	docker scan image_name|image_id


[bind_mount]
	sharing system host dir / file with container
	useful when we create a database container we can setup the file to store in our local folder
		- when we remove the container the file still exist
	--mount
		--mount "type=bind,source=/Users/budi/database,destination=/data/db,readonly"
		type - bind / volume
		source - folder location in system host
		destination - folder location in container (for database container, read the db registry doc, it will show you where they write the data inside container)
		readonly - container can't change the file
	

[docker_volume]
	docker hard disk
	docker volume ls
	automatically generated
	create custom volume
		- docker volume create mongodbvolume
	remove docker volume
		- docker volume rm mongodbvolume


[container_volume]
	container volume - same as bind mounts but we store the data in docker_volume
	if the docker volume removed the data will be lost
	diff:
		- type must be volume
		- source is not path to dir but volume name
	--mount
		--mount "type=volume,source=volume_name,destination=/data/db"


[how_to_backup_a_container_volume]
	- manually
		- stop the container 1
			- so no new data written
		- create a new container 2 using bind mount sourcing to docker volume
			- exec to bind mount container
			- do cp or tar cvf (zip) from container 1 container_volume inside docker_volume to bind mount destination
		- start the container 1 again if we still use it
	- using docker run (without creating container 2)
		docker run ...flags cp / tar cvf container_1_dir_path ~/local_dir
	

[how_to_restore_to_container_volume]
	- revert the backup process


[docker_network]
	[driver]
		1. bridge
			a. virtual network
			b. containers connected to the same network can communicated to each others
		2. host
			a. create network that same with the system host
			b. can't use different os from host
		3. none
			a. isolated - can't communicate to other containers
	
	docker network ls
	docker network create --driver driver_type network_name
	docker network rm network_name
	docker network disconnect network_name container_name
	docker network connect network_name container_name

[events]
	to monitor realtime events

	docker events
	docker events --filter'container=name'