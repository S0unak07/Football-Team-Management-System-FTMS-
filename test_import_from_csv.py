import unittest
import importlib.util
import os
import sys
import tempfile
import time
from unittest.mock import MagicMock, patch

# Load module dynamically because of hyphens in filename
spec = importlib.util.spec_from_file_location("ftms", "Football-Team-Management-System.py")
ftms = importlib.util.module_from_spec(spec)
sys.modules["ftms"] = ftms
spec.loader.exec_module(ftms)


class TestImportFromCSV(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.csv_path = os.path.join(self.temp_dir.name, "test_data.csv")

    def tearDown(self):
        self.temp_dir.cleanup()

    def create_sample_csv(self, num_rows):
        with open(self.csv_path, "w", newline="") as f:
            f.write("id,name,role,salary\n")
            for i in range(num_rows):
                if i % 2 == 0:
                    f.write(f"{i},Player_{i},Player,1000\n")
                else:
                    f.write(f"{i},Player_{i},,\n")  # contains empty strings to test NULL conversion

    @patch("builtins.input")
    @patch("ftms.make_selection")
    @patch("ftms.make_connection")
    def test_import_from_csv_correctness(self, mock_make_connection, mock_make_selection, mock_input):
        mock_input.side_effect = ["player_details", self.csv_path]
        mock_make_selection.side_effect = [
            (None, [("player_details",)]),  # SHOW TABLES
            (["id", "name", "role", "salary"], [("dummy",)]),  # SELECT * FROM table
        ]

        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_make_connection.return_value = mock_conn

        self.create_sample_csv(4)

        ftms.import_from_csv()

        mock_conn.commit.assert_called_once()
        mock_cursor.close.assert_called_once()
        mock_conn.close.assert_called_once()

        mock_cursor.executemany.assert_called_once()
        query, data = mock_cursor.executemany.call_args[0]
        self.assertEqual(query, "INSERT INTO player_details (id, name, role, salary) VALUES (%s, %s, %s, %s)")
        self.assertEqual(len(data), 4)
        self.assertEqual(data[0], ("0", "Player_0", "Player", "1000"))
        self.assertEqual(data[1], ("1", "Player_1", None, None))  # Empty string converted to None

    @patch("builtins.input")
    @patch("ftms.make_selection")
    @patch("ftms.make_connection")
    def test_import_from_csv_empty_rows(self, mock_make_connection, mock_make_selection, mock_input):
        mock_input.side_effect = ["player_details", self.csv_path]
        mock_make_selection.side_effect = [
            (None, [("player_details",)]),
            (["id", "name", "role", "salary"], [("dummy",)]),
        ]

        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_make_connection.return_value = mock_conn

        self.create_sample_csv(0)  # Only header row

        ftms.import_from_csv()

        mock_conn.commit.assert_called_once()
        mock_cursor.executemany.assert_not_called()

    def benchmark_import(self, num_rows=10000):
        self.create_sample_csv(num_rows)

        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor

        with patch("builtins.input", side_effect=["player_details", self.csv_path]), \
             patch("ftms.make_selection", side_effect=[
                 (None, [("player_details",)]),
                 (["id", "name", "role", "salary"], [("dummy",)]),
             ]), \
             patch("ftms.make_connection", return_value=mock_conn):

            start_time = time.perf_counter()
            ftms.import_from_csv()
            end_time = time.perf_counter()

            duration = end_time - start_time

            print(f"\n--- Benchmark Results ({num_rows} rows) ---")
            print(f"Time taken: {duration:.4f} seconds")
            print(f"execute call count: {mock_cursor.execute.call_count}")
            print(f"executemany call count: {mock_cursor.executemany.call_count}")
            return duration, mock_cursor.execute.call_count, mock_cursor.executemany.call_count


if __name__ == "__main__":
    unittest.main()
