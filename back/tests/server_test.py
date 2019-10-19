import server
import unittest

class ServerTest(unittest.TestCase):
    def setUp(self):
        server.app.testing = True
        self.app = server.app.test_client()

    def test_home(self):
        result = self.app.get('/')
        self.assertEqual(result.status_code, 200)
        self.assertEqual(result.json.get('msg'), 'Hello from the API application')
