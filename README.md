# Odoo Docker Quickstart

[![tests](https://github.com/Junmodeste/odoo-docker-quickstart/actions/workflows/tests.yml/badge.svg)](https://github.com/Junmodeste/odoo-docker-quickstart/actions/workflows/tests.yml)
[![Odoo 17 | 18 | 19](https://img.shields.io/badge/Odoo-17.0%20%7C%2018.0%20%7C%2019.0-714B67)](https://www.odoo.com)
[![License: LGPL-3](https://img.shields.io/badge/License-LGPL--3-blue.svg)](LICENSE)

🇫🇷 [Français](#français) · 🇬🇧 [English](#english)

## Français

Un `docker-compose.yml` prêt à l'emploi pour lancer Odoo 17, 18 ou 19 et PostgreSQL 16 en une commande, avec volumes persistants.
Déposez vos modules dans `addons/`, réglez Odoo dans `config/odoo.conf` et pilotez la stack avec le `Makefile`.

### Prérequis

- Docker avec Docker Compose v2 (`docker compose`)
- `make` (facultatif : chaque cible du Makefile est une simple commande `docker compose`)

### Installation

1. `git clone https://github.com/Junmodeste/odoo-docker-quickstart.git && cd odoo-docker-quickstart`
2. `cp .env.example .env` puis changez `POSTGRES_PASSWORD` (et `ODOO_VERSION` si besoin : 17, 18 ou 19).
3. `make up` (ou `docker compose up -d`) et ouvrez http://localhost:8069.

### Commandes

| Commande | Effet |
|---|---|
| `make up` | Démarre Odoo et PostgreSQL en arrière-plan |
| `make down` | Arrête les conteneurs (données conservées dans les volumes) |
| `make logs` | Suit les logs d'Odoo |
| `make shell DB=odoo` | Shell Python Odoo sur la base `odoo` |
| `make update-module MODULE=mon_module DB=odoo` | Met à jour un module |
| `make test MODULE=mon_module DB=test` | Installe ou met à jour un module et lance ses tests (`--test-tags=/mon_module`) ; utilisez une base de test |

### Module d'exemple

`addons/quickstart_example/` est un module minimal (un modèle, un champ calculé, des droits d'accès, deux tests) qui s'installe tel quel sur Odoo 17, 18 et 19 : la version du manifeste (`1.0.0`) ne porte pas de préfixe, Odoo y ajoute la sienne. Copiez-le comme point de départ ou supprimez-le. La CI l'installe et le teste sur les trois versions avec `make test` puis `make update-module`.

```bash
make up
docker compose exec odoo odoo -d test -i base --stop-after-init --no-http
make test MODULE=quickstart_example DB=test
```

### Structure

```
addons/            vos modules (monté sur /mnt/extra-addons), dont quickstart_example
config/odoo.conf   configuration Odoo (montée sur /etc/odoo)
.env.example       identifiants PostgreSQL et port à copier vers .env
```

Volumes : `db-data` (base PostgreSQL) et `odoo-data` (filestore, sessions). `docker compose down -v` les supprime.

Avant toute mise en ligne, définissez `admin_passwd` dans `config/odoo.conf` et placez Odoo derrière un proxy HTTPS.

### Versions supportées

Odoo **17.0**, **18.0** et **19.0** (images officielles `odoo:17`, `odoo:18`, `odoo:19`) avec PostgreSQL 16. Choisissez la version avec `ODOO_VERSION` dans `.env` (19 par défaut).

Une base créée avec une version ne s'ouvre pas avec une autre. Pour changer de version sans perdre vos données, lancez la nouvelle version dans un projet séparé (volumes distincts) : `COMPOSE_PROJECT_NAME=odoo17 ODOO_VERSION=17 docker compose up -d`.

### Licence

[LGPL-3](LICENSE)

### Auteur

Koffi Modeste Junior — [@Junmodeste](https://github.com/Junmodeste)

## English

A ready-to-use `docker-compose.yml` that starts Odoo 17, 18 or 19 and PostgreSQL 16 with one command, with persistent volumes.
Put your modules in `addons/`, tune Odoo in `config/odoo.conf` and drive the stack with the `Makefile`.

### Requirements

- Docker with Docker Compose v2 (`docker compose`)
- `make` (optional: every Makefile target is a plain `docker compose` command)

### Installation

1. `git clone https://github.com/Junmodeste/odoo-docker-quickstart.git && cd odoo-docker-quickstart`
2. `cp .env.example .env` and change `POSTGRES_PASSWORD` (and `ODOO_VERSION` if needed: 17, 18 or 19).
3. `make up` (or `docker compose up -d`) and open http://localhost:8069.

### Commands

| Command | Effect |
|---|---|
| `make up` | Start Odoo and PostgreSQL in the background |
| `make down` | Stop the containers (data kept in volumes) |
| `make logs` | Follow Odoo logs |
| `make shell DB=odoo` | Odoo Python shell on database `odoo` |
| `make update-module MODULE=my_module DB=odoo` | Update a module |
| `make test MODULE=my_module DB=test` | Install or update a module and run its tests (`--test-tags=/my_module`); use a test database |

### Example module

`addons/quickstart_example/` is a minimal module (one model, one computed field, access rights, two tests) that installs as is on Odoo 17, 18 and 19: its manifest version (`1.0.0`) has no series prefix, so Odoo prepends its own. Copy it as a starting point or delete it. CI installs and tests it on all three versions with `make test` then `make update-module`.

```bash
make up
docker compose exec odoo odoo -d test -i base --stop-after-init --no-http
make test MODULE=quickstart_example DB=test
```

Volumes: `db-data` (PostgreSQL) and `odoo-data` (filestore, sessions). `docker compose down -v` deletes them.

Before going live, set `admin_passwd` in `config/odoo.conf` and put Odoo behind an HTTPS proxy.

### Supported versions

Odoo **17.0**, **18.0** and **19.0** (official `odoo:17`, `odoo:18`, `odoo:19` images) with PostgreSQL 16. Pick the version with `ODOO_VERSION` in `.env` (19 by default).

A database created with one version does not open with another. To switch versions without losing data, run the new version as a separate project (separate volumes): `COMPOSE_PROJECT_NAME=odoo17 ODOO_VERSION=17 docker compose up -d`.

### License

[LGPL-3](LICENSE)

### Author

Koffi Modeste Junior — [@Junmodeste](https://github.com/Junmodeste)
