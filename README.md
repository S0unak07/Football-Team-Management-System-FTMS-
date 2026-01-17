# Football Team Management System (FTMS) ⚽

A comprehensive, Command Line Interface (CLI) based application built with **Python** and **MySQL** designed to streamline the administrative, tactical, and financial operations of a professional football club.

The system features role-based authentication (Player, Coach, Manager, Developer), financial reporting, match analysis, and injury tracking. The current database is pre-populated with **Real Madrid** squad data (2025/2026 Season context) for demonstration purposes.

---

## 📋 Table of Contents

* [Features](https://www.google.com/search?q=%23-features)
* [Tech Stack](https://www.google.com/search?q=%23-tech-stack)
* [Database Structure](https://www.google.com/search?q=%23-database-structure)
* [Installation & Setup](https://www.google.com/search?q=%23-installation--setup)
* [Configuration](https://www.google.com/search?q=%23-configuration)
* [Usage & Roles](https://www.google.com/search?q=%23-usage--roles)
* [Project Structure](https://www.google.com/search?q=%23-project-structure)

---

## 🚀 Features

The system is divided into four distinct user roles, each with specific permissions:

### 1. 👔 Manager (Admin)

* **Squad Management:** Add/Remove players, renew contracts, and handle suspensions.
* **Financial Management:** Track revenue (sponsorships, tickets) and expenses (wages, travel).
* **Reporting:** Generate calculated financial summary reports (Net Income analysis) and export data to CSV.
* **Scheduling:** Add new match fixtures and upcoming tournaments.

### 2. 🧢 Coaching Staff

* **Training:** Assign specific training drills (Tactical, Recovery, Technical) to players.
* **Matchday:** Record match results, possession stats, and detailed post-match player ratings (goals, assists, saves).
* **Medical:** Log injuries, severity, and expected recovery dates.

### 3. 🏃 Player

* **Personal Dashboard:** View individual career stats, current season performance, and match ratings.
* **Schedule:** Check upcoming fixtures and assigned training sessions.
* **Medical:** View personal injury history.

### 4. 💻 Developer

* **Database Management:** Export the entire database to CSV files for backup.
* **Restoration:** Import table data from CSV files.
* **User Admin:** Update login credentials and roles.

---

## 🛠 Tech Stack

* **Language:** Python 3.x
* **Database:** MySQL (8.0+)
* **Python Libraries:**
* `mysql-connector-python` (Database connectivity)
* `prettytable` (Formatted CLI tables)
* `sys`, `csv`, `os`, `datetime` (Standard libraries)



---

## 🗄 Database Structure

The system uses a relational database (`ftm_system`) with the following key tables:

* **Auth & People:** `club_auth_data`, `player_details`
* **Performance:** `player_stats_club`, `player_stats_season`, `recent_match_stats`, `match_history`
* **Logistics:** `training_schedule`, `injury_log`, `suspension_log`, `club_fixtures`
* **Finance:** `club_revenue`, `club_expenses`, `club_sponsors`

---

## ⚙ Installation & Setup

### Prerequisites

1. Python installed on your machine.
2. MySQL Server installed and running.

### Step 1: Clone the Repository

```bash
git clone https://github.com/S0unak07/Football-Team-Management-System-FTMS-.git
cd football-team-management

```

### Step 2: Install Python Dependencies

```bash
pip install mysql-connector-python prettytable

```

### Step 3: Set up the Database

1. Open your MySQL Command Line Client or Workbench.
2. Import the provided SQL file to create the database and tables.

**Using Command Line:**

```bash
mysql -u root -p < ftm_system.sql

```

**Using Workbench:**

* Open MySQL Workbench.
* Go to **Server** > **Data Import**.
* Select "Import from Self-Contained File" and choose `ftm_system.sql`.
* Click **Start Import**.

---

## 🔧 Configuration

**Important:** You must update the Python script to match your local MySQL credentials.

1. Open `Football-Team-Management-System.py`.
2. Locate the `make_connection()` function (approx. line 12).
3. Update the `user` and `passwd` fields:

```python
def make_connection():
    try:
        conn = sqlconn.connect(
            host = 'localhost',
            user = 'YOUR_MYSQL_USERNAME',  # e.g., 'root'
            passwd = 'YOUR_MYSQL_PASSWORD', # e.g., 'password123'
            database = 'ftm_system')
        return conn

```

---

## 🖥 Usage & Roles

Run the main application script:

```bash
python Football-Team-Management-System.py

```

### Demo Login Credentials

The database comes pre-loaded with users. You can use these to test the system:

| Role | Login ID | Password | User Name |
| --- | --- | --- | --- |
| **Developer** | `DevSouGuh@07` | `SG007Dev` | Sounak Guha |
| **Manager** | `SnrMgXabAlo@100` | `XA100Man` | Xabi Alonso |
| **Coach** | `SnrCsSebPar@1` | `SP01CoachStf` | Sebas Parrilla |
| **Player** | `SnrPlKylMba@9` | `KM09Forward` | Kylian Mbappe |

*(Note: Refer to the `club_auth_data` table in the SQL file for all passwords).*

---

## 📂 Project Structure

```text
football-team-management/
│
├── Football-Team-Management-System.py  # Main Application Entry Point
├── ftm_system.sql                      # Database Import File
├── README.md                           # Project Documentation
│
├── Finance_Report_YYYYMMDD/            # Generated by Manager (Auto-created)
│   ├── club_revenue.csv
│   ├── club_expenses.csv
│   └── ...
│
└── [Exported_Tables]/                  # Generated by Developer (Auto-created)

```

---

## 🔮 Future Improvements

* **GUI:** Implementation of a graphical interface using Tkinter or PyQt.
* **Data Visualization:** Integration with `matplotlib` to graph player stats and financial trends.
* **Live API:** Connecting to a live football API for real-time fixture updates.

---

**Disclaimer:** This project uses fictionalized data for the 2025/2026 season based on Real Madrid CF players. All salaries and financial figures are estimates for demonstration purposes.
