# Raccourcis pour la stack Odoo (version : ODOO_VERSION dans .env). Variables : DB (base), MODULE (module à mettre à jour).
DB ?= odoo
# Port HTTP interne de `make test` : en 18/19, --test-enable démarre le serveur HTTP même avec --no-http,
# et 8069 est déjà pris par l'Odoo en cours dans le conteneur.
TEST_HTTP_PORT ?= 8169
COMPOSE = docker compose

.PHONY: up down logs shell update-module test

up: ## Démarre Odoo et PostgreSQL en arrière-plan
	$(COMPOSE) up -d

down: ## Arrête les conteneurs (les volumes sont conservés)
	$(COMPOSE) down

logs: ## Suit les logs d'Odoo
	$(COMPOSE) logs -f odoo

shell: ## Ouvre un shell Python Odoo sur la base DB
	$(COMPOSE) exec odoo odoo shell -d $(DB) --no-http

update-module: ## Met à jour MODULE sur la base DB : make update-module MODULE=mon_module DB=odoo
	@test -n "$(MODULE)" || (echo "Usage : make update-module MODULE=mon_module [DB=odoo]" && exit 1)
	$(COMPOSE) exec odoo odoo -d $(DB) -u $(MODULE) --stop-after-init --no-http

test: ## Installe ou met à jour MODULE sur DB et lance ses tests : make test MODULE=mon_module DB=test
	@test -n "$(MODULE)" || (echo "Usage : make test MODULE=mon_module [DB=odoo]" && exit 1)
	$(COMPOSE) exec odoo odoo -d $(DB) -i $(MODULE) -u $(MODULE) --test-enable --test-tags=/$(MODULE) --stop-after-init --http-port=$(TEST_HTTP_PORT)
