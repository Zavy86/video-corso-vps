init:
	docker network create --driver bridge reverse-proxy

portainer:
	docker volume create portainer_data

