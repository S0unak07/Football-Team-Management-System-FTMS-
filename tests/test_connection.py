import unittest
from unittest.mock import patch, MagicMock
import os
import sys
import importlib.util

# Dynamically import Football-Team-Management-System.py
module_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "Football-Team-Management-System.py")
spec = importlib.util.spec_from_file_location("ftms", module_path)
ftms = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ftms)


class TestDatabaseConnection(unittest.TestCase):

    @patch("mysql.connector.connect")
    def test_make_connection_defaults(self, mock_connect):
        mock_conn = MagicMock()
        mock_connect.return_value = mock_conn

        with patch.dict(os.environ, {}, clear=True):
            conn = ftms.make_connection()
            self.assertEqual(conn, mock_conn)
            mock_connect.assert_called_once_with(
                host="localhost",
                user="root",
                passwd="",
                database="ftm_system"
            )

    @patch("mysql.connector.connect")
    def test_make_connection_custom_env(self, mock_connect):
        mock_conn = MagicMock()
        mock_connect.return_value = mock_conn

        env_vars = {
            "DB_HOST": "db.example.com",
            "DB_USER": "testuser",
            "DB_PASSWORD": "secretpassword",
            "DB_NAME": "test_db"
        }

        with patch.dict(os.environ, env_vars, clear=True):
            conn = ftms.make_connection()
            self.assertEqual(conn, mock_conn)
            mock_connect.assert_called_once_with(
                host="db.example.com",
                user="testuser",
                passwd="secretpassword",
                database="test_db"
            )

    @patch("mysql.connector.connect")
    def test_make_connection_passwd_fallback(self, mock_connect):
        mock_conn = MagicMock()
        mock_connect.return_value = mock_conn

        env_vars = {
            "DB_HOST": "localhost",
            "DB_USER": "root",
            "DB_PASSWD": "fallbackpassword",
            "DB_NAME": "ftm_system"
        }

        with patch.dict(os.environ, env_vars, clear=True):
            conn = ftms.make_connection()
            self.assertEqual(conn, mock_conn)
            mock_connect.assert_called_once_with(
                host="localhost",
                user="root",
                passwd="fallbackpassword",
                database="ftm_system"
            )


if __name__ == "__main__":
    unittest.main()
