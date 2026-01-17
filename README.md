# Football Team Management System (FTMS)

A comprehensive Python and MySQL-based application designed to manage the day-to-day operations of a professional football club.

## Requirements
1. **Python 3.x**
2. **MySQL Server** (8.0 or higher recommended)
3. **Python Libraries:** You need to install `mysql-connector-python` and `prettytable`.

### Install Required Modules
Open your command prompt or terminal and run:
```bash
pip install mysql-connector-python prettytable
```

## Installation & Database Setup
### Step 1: Import the Database
1. Open your MySQL Command Line Client.
2. Create the database:
```sql
CREATE DATABASE ftm_system;
```
3. Import the provided SQL file. Using Command Line:
```bash
mysql -u root -p ftm_system < ftm_system.sql
```

### Step 2: Configure the Database Connection

1. Open the python file `Football-Team-Management-System.py` in your code editor (IDLE, Thonny, etc.).
2. Locate the `make_connection()` function near the top of the file (Lines 14-18).
3. Update the `passwd` field with **your** MySQL root password:


## 🔐 Default Login Credentials

The database comes pre-populated with data (based on the Real Madrid 2025/26 squad). You can use the following credentials to test different roles:

| Role | Login ID | Password | User Name |
| --- | --- | --- | --- |
| **Developer** | `DevSouGuh@07` | `SG007Dev` | Sounak Guha |
| **Manager** | `SnrMgXabAlo@100` | `XA100Man` | Xabi Alonso |
| **Coach** | `SnrCsSebPar@1` | `SP01CoachStf` | Sebas Parrilla |
| **Player** | `SnrPlKylMba@9` | `KM09Forward` | Kylian Mbappe |

> **Note:** You can also register a new user from the main menu (Option 2).

## ⚠️ Troubleshooting

* **Database Connection Error:** Ensure your MySQL server is running and the password in the Python script matches your local MySQL password.
* **"Table doesn't exist"**: Make sure you successfully imported the `ftm_system.sql` file into a database named exactly `ftm_system`.
