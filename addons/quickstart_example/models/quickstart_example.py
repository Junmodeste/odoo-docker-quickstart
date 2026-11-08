from odoo import api, fields, models


class QuickstartExample(models.Model):
    _name = "quickstart.example"
    _description = "Quickstart Example"
    _order = "name"

    name = fields.Char(required=True)
    note = fields.Text()
    name_length = fields.Integer(compute="_compute_name_length", store=True)

    @api.depends("name")
    def _compute_name_length(self):
        for record in self:
            record.name_length = len(record.name or "")
