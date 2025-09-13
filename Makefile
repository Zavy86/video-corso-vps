# Function: Docker Rebuild
# [execute: down, remove, pull, build, up]
# $(call docker_rebuild,"stack_name")
define docker_rebuild
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml down && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml rm -f && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml pull && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml build --no-cache && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml up -d
endef
# Function: Docker Remove
# [execute: down, remove]
# $(call docker_remove,"stack_name")
define docker_remove
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml down && \
	docker compose -p $(1) -f docker/$(1)/docker-compose.yml rm -f
endef
# Initialization
init:
	docker network create --driver bridge reverse-proxy
# Remove Stack
remove:
	@if [ -z "$(stack)" ]; then echo "usage: make remove stack=portainer"; exit 1; fi
	$(call docker_remove,$(stack))
# Portainer
portainer:
	docker volume create portainer_data
	$(call docker_rebuild,"portainer")
# NGINX Proxy Manager
nginxpm:
	docker volume create nginxpm_data
	docker volume create nginxpm_letsencrypt
	$(call docker_rebuild,"nginxpm")
# Gotify
gotify:
	docker volume create gotify_data
	$(call docker_rebuild,"gotify")
# WatchTower
watchtower:
	$(call docker_rebuild,"watchtower")
# Glances
glances:
	$(call docker_rebuild,"glances")
# IT Tools
it-tools:
	$(call docker_rebuild,"it-tools")
# Passbolt
passbolt:
	docker volume create passbolt_db
	docker volume create passbolt_gpg
	docker volume create passbolt_jwt
	$(call docker_rebuild,"passbolt")
# Uptime Kuma
uptime-kuma:
	docker volume create uptime-kuma_data
	$(call docker_rebuild,"uptime-kuma")
# N8N
n8n:
	docker volume create n8n_data
	$(call docker_rebuild,"n8n")
# Papra
papra:
	docker volume create papra_data
	$(call docker_rebuild,"papra")
