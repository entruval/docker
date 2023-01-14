[info]
	docker file name must be 'Dockerfile'

[commands]
	docker build flags folder_name commands
	[flags]
		-t 
			set image name
			-t name Dockerfile_folder
			-t image_1 exercises/dockerfile/from
			for personal projects use your docker hub account
			-t docker_hub_account/image_name . -- use . if in the same folder
	[commands]
		--progress
			print details
			--progress=plain
		--no-cache
			by default docker do cache when build
			if no changes in Dockerfile, build will run from cache

[instruction]
	INSTRUCTION commands
	INSTRUCTION -- uppercase preferable

	[FROM]
		create a image build stage
		FROM image:version as alias_name
		FROM alpine:3

		[MULTI STAGE BUILD]
			use multiple FROM
			must use alias
			first FROM usually used for preparation (install images, compile, build, etc)
			second FROM usually used to run the programm, COPY exe | compile | build files from first FORM

	[RUN]
		exec command or [commands] once when in build stage
		RUN command
		RUN [commands]
			RUN mkdir project
			RUN echo "hello"
			RUN cat project

	[CMD]
		exec command once when docker is already running
		not all CMD executed
			if multiples CMD defined, only the latest one is executed
		[format]
			CMD command param param
			CMD ["command", "param", "param"]
			CMD ["param", "param"] -- using executable ENTRY POINT

	[LABEL]
		to add metadata in docker image (additional informations - app_name | creator | website | company | license | etc)
		this will not affects docker image or container
		LABEL key=value
		LABEL key=value key=value
		
	[ADD]
		to add files from source dir or URL to destination dir
		it can detect the file extension
			if compressed ? it will be extracted
		ADD source destination
		ADD world.txt docker/hello # world.txt will be add to docker/hello dir
		ADD *.txt docker/hello # all files with .txt extenstion will be add to docker/hello dir
		
		[match_pattern]
			'*' 																	matches any sequence of non-separator characters (all)
			'?' 																	matches any single non-separator characters (single)
			'[' [ '^' ] { character-range } ']'		character class (must be non-empty)
			c																			matches character c (c != '*', '?', '\\', '[')
			'\\' c																matches character c
		
		[character_range]
			c							matches character c (c != '*', '?', '\\', '[')
			'\\' c				matches character c
			lo '-' hi			matches character c for lo <= c <= hi

	[COPY]
		same as ADD
		can't download file from URL
		can't extract compressed file
		best practices -- better use COPY instead of ADD, for extracting compressed file use RUN

	[EXPOSE]
		to inform that container will listen at port with specified number or protocol
		!= publish
		just for documentation

		EXPOSE port				-- default is tcp
		EXPOSE port/tcp
		EXPOSE port/udp

		"ExposedPorts": {} 		will be written in image when we inspect it

	[ENV]
		set or update env in build stage or running stage
		we can call defined ENV using ${ENV_NAME}
		stored in docker image, inspect the image to see it

	[VOLUME]
		to create volume when container created
		volume will be stored inside docker volume eventhough we did not create one

		VOLUME path_to_dir													single
		VOLUME path_to_dir path_to_dir2							multiple
		VOLUME ["path_to_dir", "path_to_dir2"]			multiple

	[WORKDIR]
		to define dir where instructions triggered (RUN, CMD, ENTRYPOINT, COPY and ADD)
		will create one if dir not exist
		if WORKDIR is a relative path (multiple WORKDIR defined)
			it will automatically use previous WORKDIR
		can be used to defined home path when we connect to the container

		WORKDIR path							-- /app
		WORKDIR docker						-- /app/docker
		WORKDIR /home/docker			-- /home/docker not /app/docker

	[USER]
		to change user or user group when docker image run
		by default user is root
		make sure to create the user first

		RUN mkdir /app
		RUN addgroup -S exercises
		RUN adduser -S -D -h /app newuser password
		RUN chown -R newuser:exercises /app
		USER user

	[ARG]
		to define variable that can be used when in build stage
			--build-arg key=default_value
		${variable_name}
		value can be change when we redefined it on build command

		ARG key					-- if value not defined, we required to define it on build command
		ARG key=default_value

	[HEALTHCHECK]
		statuses
			starting		-- default
			healthy
			unhealthy

		HEALTHCHECK NONE			-- disable
		HEALTHCHECK [options] CMD command
		
		[options]
			--interval=30s				-- default 30s
			--timeout=30s					-- default 30s
			--start-period=0s			-- default 0s
			--retries=3						-- default 3 tries

		docker container inspect health

	[ENTRYPOINT]
		to run executable file (.exe)

		ENTRYPOINT executable param param
		ENTRYPOINT ["executable", "param", 'param']
		CMD ["param", "param"]													-- this will send the params to ENTRYPOINT

		ENTRYPOINT ["node"]
		CMD ["/Projects/script.js"]
		equal to
		CMD ["node", "/Projects/script.js"]

		
