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
| `make test-fresh MODULE=mon_module` | Lance les tests du module sur une base neuve `test_mon_module` (créée par Odoo, supprimée avec son filestore si les tests passent, gardée pour analyse sinon) ; autre nom : `TEST_DB=…` |

### Module d'exemple

`addons/quickstart_example/` est un module minimal (un modèle, un champ calculé, des droits d'accès, deux tests) qui s'installe tel quel sur Odoo 17, 18 et 19 : la version du manifeste (`1.0.0`) ne porte pas de préfixe, Odoo y ajoute la sienne. Copiez-le comme point de départ ou supprimez-le. La CI l'installe et le teste sur les trois versions avec `make test`, `make update-module` puis `make test-fresh`.

```bash
make up
make test-fresh MODULE=quickstart_example
```

Odoo crée lui-même une base absente passée avec `-d` : `make test` fonctionne aussi sur une base qui n'existe pas encore.

### Dépendances Python (image personnalisée, facultatif)

Si vos modules ont besoin de paquets Python absents de l'image officielle (`external_dependencies` du manifeste), listez-les dans `requirements.txt` puis activez l'image personnalisée : `Dockerfile` part de `odoo:<ODOO_VERSION>` et installe ces paquets, `docker-compose.build.yml` remplace l'image du service `odoo`.

```bash
echo "humanize==4.9.0" >> requirements.txt
docker compose -f docker-compose.yml -f docker-compose.build.yml up -d
```

Pour que `make` et `docker compose` l'utilisent toujours, décommentez la ligne `COMPOSE_FILE=…` de votre système dans `.env`. L'image est reconstruite à chaque `up` (`pull_policy: build`, cache Docker), donc une modification de `requirements.txt` est prise en compte sans autre commande. Sur Odoo 18 et 19 (Ubuntu 24.04), l'installation passe outre la protection PEP 668 du Python système : n'épinglez pas à d'autres versions les paquets déjà fournis par l'image (`lxml`, `psycopg2`…). La CI construit cette image et importe un paquet ajouté sur les trois versions.

### Structure

```
addons/                   vos modules (monté sur /mnt/extra-addons), dont quickstart_example
config/odoo.conf          configuration Odoo (montée sur /etc/odoo)
.env.example              identifiants PostgreSQL et port à copier vers .env
Dockerfile                image personnalisée facultative (odoo:<version> + requirements.txt)
docker-compose.build.yml  surcharge qui active cette image
requirements.txt          paquets Python de vos modules (image personnalisée seulement)
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
| `make test-fresh MODULE=my_module` | Run the module's tests on a brand-new `test_my_module` database (created by Odoo, dropped with its filestore when the tests pass, kept for inspection otherwise); other name: `TEST_DB=…` |

### Example module

`addons/quickstart_example/` is a minimal module (one model, one computed field, access rights, two tests) that installs as is on Odoo 17, 18 and 19: its manifest version (`1.0.0`) has no series prefix, so Odoo prepends its own. Copy it as a starting point or delete it. CI installs and tests it on all three versions with `make test`, `make update-module` then `make test-fresh`.

```bash
make up
make test-fresh MODULE=quickstart_example
```

Odoo creates a missing database passed with `-d` by itself: `make test` also works on a database that does not exist yet.

### Python dependencies (custom image, optional)

If your modules need Python packages missing from the official image (manifest `external_dependencies`), list them in `requirements.txt` and enable the custom image: `Dockerfile` starts from `odoo:<ODOO_VERSION>` and installs them, `docker-compose.build.yml` swaps the image of the `odoo` service.

```bash
echo "humanize==4.9.0" >> requirements.txt
docker compose -f docker-compose.yml -f docker-compose.build.yml up -d
```

To make `make` and `docker compose` always use it, uncomment the `COMPOSE_FILE=…` line for your OS in `.env`. The image is rebuilt on every `up` (`pull_policy: build`, Docker cache), so a change to `requirements.txt` is picked up with no extra command. On Odoo 18 and 19 (Ubuntu 24.04) the install overrides the PEP 668 protection of the system Python: do not pin packages already shipped by the image (`lxml`, `psycopg2`…) to other versions. CI builds this image and imports an added package on all three versions.

Volumes: `db-data` (PostgreSQL) and `odoo-data` (filestore, sessions). `docker compose down -v` deletes them.

Before going live, set `admin_passwd` in `config/odoo.conf` and put Odoo behind an HTTPS proxy.

### Supported versions

Odoo **17.0**, **18.0** and **19.0** (official `odoo:17`, `odoo:18`, `odoo:19` images) with PostgreSQL 16. Pick the version with `ODOO_VERSION` in `.env` (19 by default).

A database created with one version does not open with another. To switch versions without losing data, run the new version as a separate project (separate volumes): `COMPOSE_PROJECT_NAME=odoo17 ODOO_VERSION=17 docker compose up -d`.

### License

[LGPL-3](LICENSE)

### Author

Koffi Modeste Junior — [@Junmodeste](https://github.com/Junmodeste)
