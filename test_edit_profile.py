import unittest
from unittest.mock import patch
import io
import importlib.util
import sys

# Load the module dynamically due to dashes in filename
spec = importlib.util.spec_from_file_location("ftms", "Football-Team-Management-System.py")
ftms = importlib.util.module_from_spec(spec)
sys.modules["ftms"] = ftms
spec.loader.exec_module(ftms)

class TestEditProfile(unittest.TestCase):
    @patch('builtins.input', side_effect=['age', 'not_an_int'])
    @patch('sys.stdout', new_callable=io.StringIO)
    @patch('ftms.make_entry')
    def test_edit_profile_invalid_age(self, mock_make_entry, mock_stdout, mock_input):
        ftms.edit_profile('P001')
        output = mock_stdout.getvalue()
        self.assertIn("Age must be an integer. Update cancelled.", output)
        mock_make_entry.assert_not_called()

if __name__ == '__main__':
    unittest.main()
