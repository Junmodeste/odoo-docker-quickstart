{
    "name": "Quickstart Example",
    "summary": "Minimal example module mounted from addons/ (Odoo 17, 18 and 19)",
    # No series prefix: Odoo prepends the running version (17.0.1.0.0, 18.0.1.0.0, 19.0.1.0.0).
    "version": "1.0.0",
    "category": "Hidden",
    "author": "Koffi Modeste Junior",
    "website": "https://github.com/Junmodeste/odoo-docker-quickstart",
    "license": "LGPL-3",
    "depends": ["base"],
    "data": ["security/ir.model.access.csv"],
    "installable": True,
}
