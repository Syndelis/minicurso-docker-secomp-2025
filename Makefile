watch:
	docker run --rm -v ${PWD}/slides:/home/marp/app/ -e MARP_USER="$(id -u):$(id -g)" marpteam/marp-cli -w main.md

