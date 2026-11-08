from odoo.tests import TransactionCase, tagged


@tagged("post_install", "-at_install")
class TestQuickstartExample(TransactionCase):
    def test_create_and_compute(self):
        record = self.env["quickstart.example"].create({"name": "Bonjour Abidjan"})
        self.assertEqual(record.name_length, 15)
        record.name = "Dakar"
        self.assertEqual(record.name_length, 5)

    def test_order_by_name(self):
        model = self.env["quickstart.example"]
        model.create([{"name": "Lomé"}, {"name": "Bamako"}])
        names = model.search([("name", "in", ["Lomé", "Bamako"])]).mapped("name")
        self.assertEqual(names, ["Bamako", "Lomé"])
