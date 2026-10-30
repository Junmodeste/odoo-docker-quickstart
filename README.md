# Odoo Docker Quickstart

[![Odoo 19](https://img.shields.io/badge/Odoo-19.0-714B67)](https://www.odoo.com)
[![License: LGPL-3](https://img.shields.io/badge/License-LGPL--3-blue.svg)](LICENSE)

🇫🇷 [Français](#français) · 🇬🇧 [English](#english)

## Français

Un `docker-compose.yml` prêt à l'emploi pour lancer Odoo 19 et PostgreSQL 16 en une commande, avec volumes persistants.
Déposez vos modules dans `addons/`, réglez Odoo dans `config/odoo.conf` et pilotez la stack avec le `Makefile`.

### Prérequis

- Docker avec Docker Compose v2 (`docker compose`)
- `make` (facultatif : chaque cible du Makefile est une simple commande `docker compose`)

### Installation

1. `git clone https://github.com/Junmodeste/odoo-docker-quickstart.git && cd odoo-docker-quickstart`
2. `cp .env.example .env` puis changez `POSTGRES_PASSWORD`.
3. `make up` (ou `docker compose up -d`) et ouvrez http://localhost:8069.

### Commandes

| Commande | Effet |
|---|---|
| `make up` | Démarre Odoo et PostgreSQL en arrière-plan |
| `make down` | Arrête les conteneurs (données conservées dans les volumes) |
| `make logs` | Suit les logs d'Odoo |
| `make shell DB=odoo` | Shell Python Odoo sur la base `odoo` |
| `make update-module MODULE=mon_module DB=odoo` | Met à jour un module |

### Structure

```
addons/            vos modules (monté sur /mnt/extra-addons)
config/odoo.conf   configuration Odoo (montée sur /etc/odoo)
.env.example       identifiants PostgreSQL et port à copier vers .env
```

Volumes : `db-data` (base PostgreSQL) et `odoo-data` (filestore, sessions). `docker compose down -v` les supprime.

Avant toute mise en ligne, définissez `admin_passwd` dans `config/odoo.conf` et placez Odoo derrière un proxy HTTPS.

### Version supportée

Odoo **19.0** (image officielle `odoo:19`) avec PostgreSQL 16.

### Licence

[LGPL-3](LICENSE)

### Auteur

Koffi Modeste Junior — [@Junmodeste](https://github.com/Junmodeste)

## English

A ready-to-use `docker-compose.yml` that starts Odoo 19 and PostgreSQL 16 with one command, with persistent volumes.
Put your modules in `addons/`, tune Odoo in `config/odoo.conf` and drive the stack with the `Makefile`.

### Requirements

- Docker with Docker Compose v2 (`docker compose`)
- `make` (optional: every Makefile target is a plain `docker compose` command)

### Installation

1. `git clone https://github.com/Junmodeste/odoo-docker-quickstart.git && cd odoo-docker-quickstart`
2. `cp .env.example .env` and change `POSTGRES_PASSWORD`.
3. `make up` (or `docker compose up -d`) and open http://localhost:8069.

### Commands

| Command | Effect |
|---|---|
| `make up` | Start Odoo and PostgreSQL in the background |
| `make down` | Stop the containers (data kept in volumes) |
| `make logs` | Follow Odoo logs |
| `make shell DB=odoo` | Odoo Python shell on database `odoo` |
| `make update-module MODULE=my_module DB=odoo` | Update a module |

Volumes: `db-data` (PostgreSQL) and `odoo-data` (filestore, sessions). `docker compose down -v` deletes them.

Before going live, set `admin_passwd` in `config/odoo.conf` and put Odoo behind an HTTPS proxy.

### Supported version

Odoo **19.0** (official `odoo:19` image) with PostgreSQL 16.

### License

[LGPL-3](LICENSE)

### Author

Koffi Modeste Junior — [@Junmodeste](https://github.com/Junmodeste)
