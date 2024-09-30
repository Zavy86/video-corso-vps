define docker_rebuild
	docker compose -f $(1) -p $(2) down && \
	docker compose -f $(1) -p $(2) rm -f && \
	docker compose -f $(1) -p $(2) pull && \
	docker compose -f $(1) -p $(2) build --no-cache && \
	docker compose -f $(1) -p $(2) build up -d
endef

init:
	docker network create --driver bridge reverse-proxy

portainer:
	docker volume create portainer_data
	$(call docker_rebuild,"docker/portainer/docker-compose.yml","portainer")
