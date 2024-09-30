define docker_rebuild
	docker compose -p $(1) -f $(2)/docker-compose.yml down && \
	docker compose -p $(1) -f $(2)/docker-compose.yml rm -f && \
	docker compose -p $(1) -f $(2)/docker-compose.yml pull && \
	docker compose -p $(1) -f $(2)/docker-compose.yml build --no-cache && \
	docker compose -p $(1) -f $(2)/docker-compose.yml up -d
endef

init:
	docker network create --driver bridge reverse-proxy

portainer:
	docker volume create portainer_data
	$(call docker_rebuild,"portainer","docker/portainer")
