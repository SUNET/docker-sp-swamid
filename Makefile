all: build tag push
update:
	docker build -t sp-swamid .
build:
	docker build --no-cache=true -t sp-swamid .
tag:
	docker tag -f sp-swamid docker.sunet.se/sp-swamid
push:
	docker push docker.sunet.se/sp-swamid	
