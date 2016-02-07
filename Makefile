.PHONY: all build start stop clean realclean

export HOST_UID=$(shell id -u)
export HOST_GID=$(shell id -g)
export HOST_USER=$(shell id -nu)
export HOST_GROUP=$(shell id -ng)

all: start

erlang/your_key.pub: ~/.ssh/id_rsa.pub
	cp -f ~/.ssh/id_rsa.pub erlang/your_key.pub

build: erlang/your_key.pub
	docker-compose build

start: build
	docker-compose run --rm erlang /root/startup.sh

stop:
	docker-compose stop

clean: stop
	docker-compose down

realclean: clean
	@docker rm -v $(shell docker ps -a -q -f status=exited) 2>/dev/null || true
	@docker rmi $(shell docker images -q) 2>/dev/null || true
	@docker rm $(shell docker ps -a -q) 2>/dev/null || true
