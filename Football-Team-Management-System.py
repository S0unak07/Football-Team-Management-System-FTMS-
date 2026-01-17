import mysql.connector as sqlconn
import sys
import csv
import os
from prettytable import PrettyTable
from datetime import datetime
import time

#------------------#
#    CONNECTION    #
#------------------#
def make_connection():
    try:
        conn = sqlconn.connect(
            host = 'localhost',
            user = 'root',
            passwd = '0987',
            database = 'ftm_system')
        return conn
    except sqlconn.Error as e:
        print("Database connection Error", e)
        print("Exiting...")
        sys.exit(0)
        
#-----------------#
#    EXECUTION    #
#-----------------#

def make_selection(query, parameter = None):
    conn = make_connection()
    cursor = conn.cursor()
    if parameter is None:
        cursor.execute(query) #Non-parameterized query
    else: 
        cursor.execute(query, parameter) #Parameterized query
        
    columns = [i[0] for i in cursor.description] #select column names (generator experssion)
    rows = cursor.fetchall()
    cursor.close(); conn.close()
    return columns, rows
    
def make_entry(query, values):
    conn = make_connection()
    cursor = conn.cursor()
    cursor.execute(query, values)
    conn.commit(); conn.close()

#---------------------#
#      EXPORT DATA    #
#---------------------#

def export_table(table_name, file_name = None):
    column, row = make_selection(f"SELECT * FROM {table_name}")
    if not column:
        print(f'Table "{table_name}" does not exist or has no columns.')
        return
        
    if not file_name:
        file_name = table_name #Default file_name
    try:
        with open(f'{file_name}.csv', 'w', newline = '', encoding='utf-8') as file:
            file_writer = csv.writer(file)
            file_writer.writerow(column)
            file_writer.writerows(row)
    except IOError as e:
        print(f"Error exporting table {table_name}: {e}")

def export_database(export_name):
    os.makedirs(export_name, exist_ok=True) #Make a folder with name as <export_name> in current directory
    tables = make_selection("SHOW TABLES")[1]
    for (table,) in tables:
        export_table(table)
        try:
            os.replace(f"{table}.csv", os.path.join(export_name, f"{table}.csv"))
            #Change directory of exported table from {table}.csv} to export_name/{table}.csv
        except FileNotFoundError:
            # Handles export_table failed (e.g. empty table with no columns)
            pass

# ------------------------#
#      AUTHENTICATION     #
# ------------------------#

def register_user():
    print("\n--- Register new user ---")
    logid = input("Login ID: ").strip()
    name = input("Full name: ").strip()
    password = input("Password: ").strip()
    role = input("Role (Player / Coaching Staff / Manager / Developer): ").strip().title()
    if role not in ('Player','Coaching Staff','Manager','Developer'):
        print("Invalid role. Registration cancelled.")
        return
    #Check if Login ID already present
    selection = make_selection("SELECT login_id FROM club_auth_data WHERE login_id = %s",(logid,))
    if selection[1]:
        print(f'User already present with Login ID {logid}.')
        return
    selection_name = make_selection("SELECT Name FROM club_auth_data WHERE Name = %s",(name,))
    if selection_name[1]:
        print(f'User already present with Name {name}.')
        return
    make_entry("INSERT INTO club_auth_data VALUES (%s,%s,%s,%s)", (logid, name, password, role))
    print("User created with Login ID:", logid)

def login_user():
    print("\n--- Login ---")
    logid = input("Login ID: ").strip()
    password = input("Password: ").strip()
    selection = make_selection('SELECT name, role FROM club_auth_data WHERE login_id = %s and password = %s',(logid, password))[1]
    if not selection:
        print("Invalid credentials.")
        return None, None
    user = selection[0] #Select first result from table of users
    print("Welcome,", user[0], "| Role:", user[1])
    return user[0], user[1] # Return name and role

#------------------------#
#     COMMON ACTIONS     #
#------------------------#

def list_players(show_finance=False): #Not all roles are allowed to view player salary
    if show_finance:
        query = "SELECT * FROM player_details"
    else:
        query = "SELECT player_id, name, position, nationality, jersey_no, availability, previous_club, date_of_signing, contract_expiration, age FROM player_details"    
    cols, rows = make_selection(query)     
    table = PrettyTable(cols)
    table.add_rows(rows)
    print(f"\n--- Player Details ---\n",table)

def search_player(show_finance=False):
    print("\n--- Player Finder ---")
    field = input("Search using (Player_id/ Name): ").lower().strip()
    if field not in ('player_id', 'name'):
        print("Invalid field")
        return
    search = input("Search: ").strip()
    if show_finance:
        query = f"SELECT * FROM player_details WHERE {field} = %s"
    else:
        query = f"SELECT player_id, name, position, nationality, jersey_no, availability, previous_club, date_of_signing, contract_expiration, age FROM player_details WHERE {field} = %s"    
    cols, rows = make_selection(query, (search,))
    if not rows:
        print("Player not found.")
        return   
    table = PrettyTable(cols)
    table.add_rows(rows)
    print("\n--- Search Result ---\n",table)
    
#------------------------#
#     PLAYER ACTIONS     #
#------------------------#

def view_profile(player_id):
    cols, rows = make_selection("SELECT * FROM player_details WHERE player_id = %s", (player_id,))
    if not rows:
        print("No player profile found for your ID.")
        return
    table = PrettyTable(cols)
    table.add_row(rows[0])
    print("\n--- Player Profile ---\n",table)

def edit_profile(player_id):
    print("\n--- Player Profile Editor ---")
    field = input("Field to update (position/nationality/age): ").lower().strip()
    if field not in ('position', 'nationality', 'age'):
        print("Invalid field")
        return    
    val = input("New value: ").strip()
    #Convert 'age' into integer for database entry
    if field == 'age':
        try:
            val = int(val)
        except ValueError:
            print("Age must be an integer. Update cancelled.")
            return

    make_entry(f"UPDATE player_details SET {field} = %s WHERE player_id = %s", (val, player_id))
    print("Profile updated for Player ID",player_id)

def view_club_stats(player_id):
    cols, rows = make_selection("SELECT * FROM player_stats_club WHERE player_id = %s", (player_id,))
    if not rows:
        print("No career stats available.")
        return
    table = PrettyTable(cols); table.add_row(rows[0])
    print("\n--- Career Stats for Club ---\n",table)

def view_season_stats(player_id):
    cols, rows = make_selection("SELECT * FROM player_stats_season WHERE player_id = %s", (player_id,))
    if not rows:
        print("No stats available for current season.")
        return
    table = PrettyTable(cols); table.add_row(rows[0])
    print("\n--- Season Stats ---\n",table)

def view_recent_match_performance(player_id):
    cols, rows = make_selection('''SELECT r.match_id, m.date_played, m.opponent_name, r.goals, r.assists, r.saves,
                                     r.minutes_played, r.yellow_cards, r.red_cards, r.rating 
                                     FROM recent_match_stats r JOIN match_history m ON r.match_id = m.match_id 
                                     WHERE r.player_id = %s''', (player_id,))
    if not rows:
        print("No recent match record found.")
        return
    table = PrettyTable(cols)
    table.add_rows(rows)
    print("\n--- Recent Match Performance ---\n",table)
    
def view_injury_history(player_id):
    cols, rows = make_selection("SELECT * FROM injury_log WHERE player_id = %s ORDER BY injury_date DESC", (player_id,))
    if not rows:
        print("No injury history found.")
        return
    table = PrettyTable(cols); table.add_rows(rows)
    print("\n--- Injury History ---\n",table)

def view_training_schedule(player_id):
    cols, rows = make_selection("SELECT * FROM training_schedule WHERE player_id = %s ORDER BY date", (player_id,))
    if not rows:
        print("No training schedule assigned.")
        return
    table = PrettyTable(cols); table.add_rows(rows)
    print("\n--- Training Schedule ---\n",table)

def view_upcoming_matches():
    cols, rows = make_selection("SELECT * FROM club_fixtures WHERE status = 'Upcoming' ORDER BY match_date")
    if not rows:
        print("No upcoming matches.")
        return
    table = PrettyTable(cols); table.add_rows(rows)
    print("\n--- Upcoming Matches ---\n",table)

#-------------------------#
#      COACH ACTIONS      #
#-------------------------#

def assign_training():
    print("\n--- Tranining Assignment ---\n")
    training_id = input('Enter Training ID: ').strip()
    player_id = input("Player ID to assign: ").strip()
    date = input("Date (YYYY-MM-DD): ").strip()
    session_type = input("Session type: ").strip()
    notes = input("Notes: ").strip()

    # Fix: Check if training_id exists
    if make_selection("SELECT training_id FROM training_schedule WHERE training_id = %s", (training_id,))[1]:
        print("Training already assigned with ID", training_id)
        return
    # Fix: Check if player_id exists
    if not make_selection("SELECT player_id FROM player_details WHERE player_id = %s", (player_id,))[1]:
        print("No player with Player ID", player_id)
        return
    try:
        datetime.strptime(date, "%Y-%m-%d") #Parse as date only if 'date' is in YYYY-MM-DD format
    except ValueError: #Date in not in YYYY-MM-DD format
        print("Unable to assign training. Invaid Date for Format")
        print("Date format must be YYYY-MM-DD for successful entry")
        return
    make_entry("INSERT INTO training_schedule VALUES (%s,%s,%s,%s,%s)",(training_id, player_id, date, session_type, notes))
    print("Training assigned. (Note: Date format must be YYYY-MM-DD for successful entry)")


def update_training():
    print("\n--- Tranining Update ---\n")
    training_id = input("Training ID to update: ").strip()
    if not make_selection("SELECT training_id FROM training_schedule WHERE training_id = %s", (training_id,))[1]:
        print("No training with Training ID", training_id)
        return
    
    field = input("Field to update (date/session_type/notes): ").lower().strip()
    if field not in ('date', 'session_type', 'notes'):
        print("Invalid field")
        return
    val = input("New value: ").strip()
    if field == 'date':
        try:
            datetime.strptime(val, "%Y-%m-%d")
        except ValueError:
            print("Unable to update training. Invaid Date for Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            return    
    make_entry(f"UPDATE training_schedule SET {field} = %s WHERE training_id = %s", (val, training_id))
    print("Traning updated for Training ID",training_id)    

def record_injury():
    print("\n--- Injury Record ---\n")
    injury_id = input('Injury ID: ').strip()
    player_id = input("Player ID: ").strip()
    injury_type = input("Injury type: ").strip()
    injury_date = input("Injury date (YYYY-MM-DD): ").strip()
    exp_recovery = input("Expected recovery date (YYYY-MM-DD): ").strip()
    severity = input("Severity (Low/Moderate/High): ").strip().title()
    
    # Fix: Check if injury_id exists
    if make_selection("SELECT injury_id FROM injury_log WHERE injury_id = %s", (injury_id,))[1]:
        print("Injury already registered onto Injury ID", injury_id)
        return
    # Fix: Check if player_id exists
    if not make_selection("SELECT player_id FROM player_details WHERE player_id = %s", (player_id,))[1]:
        print("No player with Player ID ",player_id)
        return
    try:
        datetime.strptime(injury_date, "%Y-%m-%d")
        datetime.strptime(exp_recovery, "%Y-%m-%d")
    except ValueError:
        print("Unable to log injury. Invaid Date for Format")
        print("Date format must be YYYY-MM-DD for successful entry")
        return      
    if severity not in ('Low','Moderate','High'): #Check for valid severity
        print("Invalid severity. Injury not logged.")
        print("Severity must be within ('Low','Moderate','High') for successful entry")
        return     
    make_entry("INSERT INTO injury_log (injury_id, player_id, injury_type, injury_date, expected_recovery_date, severity) VALUES (%s,%s,%s,%s,%s,%s)",
               (injury_id, player_id, injury_type, injury_date, exp_recovery, severity))
    #Change player availabilty to 'Injured'
    make_entry("UPDATE player_details SET availability = %s WHERE player_id = %s", ('Injured', player_id))
    print("Injury logged and player marked Injured.")


def record_post_match_performance():
    print("\n--- Post-match Performance Record ---\n")
    match_id = input("Match ID: ").strip()
    # Fix: Check if match_id exists (in match_history i.e, match is already completed)
    if not make_selection("SELECT match_id FROM match_history WHERE match_id = %s", (match_id,))[1]:
        print("Invalid Match ID",match_id)
        print("Either the ID does not exist or the match is not yet complete")
        return
        
    print("Enter performance for each player. Blank player ID to finish.")
    while True:
        pid = input("Player ID: ").strip()
        if pid == '':
            break    
        # Fix: Check if player_id exists
        if not make_selection("SELECT player_id FROM player_details WHERE player_id = %s", (pid,))[1]:
            print("No player with Player ID ",pid)
            continue
            
        try:
            goals = int(input("Goals: ").strip())
            assists = int(input("Assists: ").strip())
            saves = int(input("Saves: ").strip())
            mins = int(input("Minutes played: ").strip())
            yellow = int(input("Yellow cards: ").strip())
            red = int(input("Red cards: ").strip())
            #Ensure rating is treated as float/decimal
            rating = float(input("Rating (e.g. 7.50): ").strip())
        except ValueError:
            print("Invalid number format for a stat (must be integer or float). Skipping this player.")
            continue
            #Stats not recorded for player, moving on to next entry
            
        # Delete existing record for this player to ensure only one (recent match) entry
        make_entry("DELETE FROM recent_match_stats WHERE player_id = %s", (pid,))
        make_entry("INSERT INTO recent_match_stats VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",(match_id, pid, goals, assists, saves, mins, yellow, red, rating))

        #Update Overall stats for club
        cols, rows = make_selection("SELECT * FROM player_stats_club WHERE player_id = %s", (pid,))
        if rows:
            cur = rows[0]
            tot_matches = cur[2] + 1
            tot_goals = cur[3] + goals
            tot_assists = cur[4] + assists
            tot_saves = cur[5] + saves
            tot_y = cur[6] + yellow
            tot_r = cur[7] + red
            make_entry("UPDATE player_stats_club SET matches_played=%s, goals=%s, assists=%s, saves=%s, yellow_cards=%s, red_cards=%s WHERE player_id=%s",
                         (tot_matches, tot_goals, tot_assists, tot_saves, tot_y, tot_r, pid))
        #First time recording stats for club
        else:
            pname = make_selection('SELECT name FROM player_details WHERE player_id = %s',(pid,))[1][0][0]
            make_entry("INSERT INTO player_stats_club (player_id, player_name, matches_played, goals, assists, saves, yellow_cards, red_cards) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
                         (pid, pname, 1, goals, assists, saves, yellow, red))
        #Update season stats for club
        cols_season, rows_season = make_selection("SELECT * FROM player_stats_season WHERE player_id = %s", (pid,))
        if rows_season:
            cur_season = rows_season[0]
            season_matches = cur_season[1] + 1
            season_mins = cur_season[2] + mins
            season_goals = cur_season[3] + goals
            season_assists = cur_season[4] + assists
            season_y = cur_season[5] + yellow
            season_r = cur_season[6] + red
            make_entry("UPDATE player_stats_season SET matches_played=%s, minutes_played=%s, goals=%s, assists=%s, yellow_cards=%s, red_cards=%s WHERE player_id=%s",
                         (season_matches, season_mins, season_goals, season_assists, season_y, season_r, pid))
        else:
            # First match of the season for this player
            make_entry("INSERT INTO player_stats_season (player_id, matches_played, minutes_played, goals, assists, yellow_cards, red_cards) VALUES (%s,%s,%s,%s,%s,%s,%s)",
                         (pid, 1, mins, goals, assists, yellow, red))
    print("Post-match performance recorded.")
    
#---------------------------#
#      MANAGER ACTIONS      #
#---------------------------#

def add_new_player():
    print("\n--- New Player Addition ---\n")
    try: 
        pid = input("New Player ID: ").strip()
        if make_selection("SELECT player_id FROM player_details WHERE player_id = %s", (pid,))[1]:
            print(f"Error: Player ID '{pid}' already exists.")
            return
        name = input("Name: ").strip()
        position = input("Position: ").strip()
        nationality = input("Nationality: ").strip()
        jersey_no = int(input("Jersey no (int): ").strip())
        availability = input("Availability (Available/Injured/Suspended): ").strip().title() or 'Available'
        previous_club = input("Previous club: ").strip()
        salary = int(input("Yearly salary (int): ").strip())
        date_of_signing = input("Date of signing (YYYY-MM-DD): ").strip()
        contract_expiration = input("Contract expiration (YYYY-MM-DD): ").strip() 
        age = int(input("Age (int): ").strip())
    except ValueError:
        print("Error: Jersey no, Yearly salary, and Age must be integers if provided. Player not added.")
        return
    try:
            datetime.strptime(date_of_signing, "%Y-%m-%d")
            datetime.strptime(contract_expiration, "%Y-%m-%d")
    except ValueError:
            print("Unable to add player. Invaid Date for Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            return
    make_entry("INSERT INTO player_details VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
               (pid, name, position, nationality, jersey_no, availability, previous_club, salary, date_of_signing, contract_expiration, age))
    print("Player added.")

def remove_player():
    print("\n--- Player Removal ---\n")
    pid = input("Player ID to remove: ").strip()
    # Fix: Check if player_id exists using an existence check query
    if not make_selection("SELECT player_id FROM player_details WHERE player_id = %s", (pid,))[1]:
        print("No player with Player ID ",pid)
        return
    confirm = input(f"Are you sure you want to remove player with Player ID {pid}? (yes/no): ").lower().strip()
    if confirm == 'yes':
        # Delete from all child tables FIRST
        make_entry("DELETE FROM player_stats_club WHERE player_id = %s", (pid,))
        make_entry("DELETE FROM player_stats_season WHERE player_id = %s", (pid,))
        make_entry("DELETE FROM recent_match_stats WHERE player_id = %s", (pid,))
        make_entry("DELETE FROM injury_log WHERE player_id = %s", (pid,))
        make_entry("DELETE FROM suspension_log WHERE player_id = %s", (pid,))
        make_entry("DELETE FROM training_schedule WHERE player_id = %s", (pid,))
        
        # Delete from the parent table LAST
        make_entry("DELETE FROM player_details WHERE player_id = %s", (pid,))
        
        print("Player removed from database and related records.")
    else:
        print("Action cancelled. No changes were made.")

def contract_renewal():
    print("\n--- Player Contract Renewal ---\n")
    try:
        pid = input("Player ID: ").strip()
        salary = int(input("New yearly salary: ").strip())
        expiry = input("New contract expiration (YYYY-MM-DD): ").strip()
    except ValueError:
        print("Error: New yearly salary must be an integer. Update cancelled.")
        return
    try:
            datetime.strptime(expiry, "%Y-%m-%d")
    except ValueError:
            print("Unable to update contarct. Invaid Date Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            return

    make_entry("UPDATE player_details SET yearly_salary = %s, contract_expiration = %s WHERE player_id = %s", (salary, expiry, pid))
    print("Contract updated.")

def suspend_player():
    pid = input("Player ID to suspend: ").strip()
    # Fix: Check if player_id exists
    if not make_selection("SELECT player_id FROM player_details WHERE player_id = %s", (pid,))[1]:
        print("No player with Player ID ",pid)
        return
    sid = input ("Suspension ID: ")
    if make_selection("SELECT suspension_id FROM suspension_log WHERE suspension_id = %s", (sid,))[1]:
        print(f"Error: Suspension ID '{sid}' already exists.")
        return
    reason = input("Reason: ").strip() 
    try:
            suspended_on = input("Suspended on: ")
            datetime.strptime(suspended_on, "%Y-%m-%d")
    except ValueError:
            print("Unable to suspend player. Invaid Date Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            return
    try:
        matches_sus = int(input("Number of matches suspended: ").strip())
    except ValueError:
        print("Error: Number of matches suspended must be an integer. Suspension cancelled.")
        return
        
    tour = input("Tournament suspended (optional): ").strip() 
    make_entry("INSERT INTO suspension_log VALUES (%s,%s,%s,%s,%s,%s)",(sid, pid, reason, suspended_on, matches_sus, tour))
    make_entry("UPDATE player_details SET availability = %s WHERE player_id = %s", ('Suspended', pid))
    print("Player suspended and logged.")

def unsuspend_player():
    pid = input("Player ID to unsuspend: ").strip()
    make_entry("UPDATE player_details SET availability = %s WHERE player_id = %s", ('Available', pid))
    print("Player unsuspend.")

def record_club_revenue():
    print("\n--- Record Club Revenue ---\n")
    rev_id = input("Revenue ID: ").strip()
    if make_selection("SELECT revenue_id FROM club_revenue WHERE revenue_id = %s", (rev_id,))[1]:
        print(f"Error: Revenue ID '{rev_id}' already exists.")
        return
    source = input("Source (e.g., Ticket Sales, Merchandise, TV Rights): ").strip()
    try:
        amount = int(input("Amount received (e.g. 150000): ").strip()) # Removed .00 hint for integer input   
    except ValueError:
        print("Error: Amount received must be an integer. Revenue not recorded.")
        return
    revenue_date = input("Date (YYYY-MM-DD): ").strip()
    try:
            datetime.strptime(revenue_date, "%Y-%m-%d")
    except ValueError:
            print("Unable to record revenue. Invaid Date Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            return
    description = input("Description (optional): ").strip() 
        
    make_entry("INSERT INTO club_revenue VALUES (%s, %s, %s, %s, %s)",(rev_id, source, amount, revenue_date, description))
    print("Revenue recorded successfully.")

def record_club_expense():
    print("\n--- Record Club Expense ---\n")
    exp_id = input("Expense ID: ").strip()
    if make_selection("SELECT expense_id FROM club_expenses WHERE expense_id = %s", (exp_id,))[1]:
        print(f"Error: Expense ID '{exp_id}' already exists.")
        return
    category = input("Category (e.g., Travel, Maintenance, Utilities): ").strip()
    try:
        amount = int(input("Amount received (e.g. 150000): ").strip()) # Removed .00 hint for integer input   
    except ValueError:
        print("Error: Amount received must be an integer. Expense not recorded.")
        return
    expense_date = input("Date (YYYY-MM-DD): ").strip()
    try:
            datetime.strptime(expense_date, "%Y-%m-%d")
    except ValueError:
            print("Unable to record expense. Invaid Date Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            return
    description = input("Description (optional): ").strip() 
    make_entry("INSERT INTO club_expenses VALUES (%s, %s, %s, %s, %s)",(exp_id, category, amount, expense_date, description))
    print("Expense recorded successfully.")

def add_new_sponsorship():
    print("\n--- Add New Sponsorship ---\n")
    sponsor_id = input("Sponsor ID: ").strip()
    if make_selection("SELECT sponsor_id FROM club_sponsors WHERE sponsor_id = %s", (sponsor_id,))[1]:
        print(f"Error: Sponsor ID '{sponsor_id}' already exists.")
        return
    name = input("Sponsor Name: ").strip()
    try:
        contribution = int(input("Contribution Amount (e.g. 2500000): ").strip())
    except ValueError:
        print("Error: contribution must be an integer. Sponsor not recorded.")
        return
    start_year = input("Start Date (YYYY-MM-DD): ").strip()
    end_year = input("End Date (YYYY-MM-DD): ").strip()
    try:
            datetime.strptime(start_year, "%Y-%m-%d")
            datetime.strptime(end_year, "%Y-%m-%d")
    except ValueError:
            print("Unable to record sponsor. Invaid Date Format")
            print("Date format must be YYYY-MM-DD for successful entry")
            
    make_entry("INSERT INTO club_sponsors VALUES (%s, %s, %s, %s, %s)",(sponsor_id, name, contribution, start_year, end_year))             
    print("New sponsorship added successfully.")

def view_finance():
    tbnm = input ("Table to view (club_revenue/ club_expenses/ club_sponsors): ").lower().strip()
    if tbnm not in ('club_revenue', 'club_expenses', 'club_sponsors'):
        print("Invalid Table name")
        return
    cols, rows = make_selection(f"SELECT * FROM {tbnm}")
    if not rows:
        print("No data has yet been recorded in", tbnm)
        return
    table = PrettyTable(cols)
    table.add_rows(rows)
    print(table)

def generate_financial_report():
    print("\n--- Generating Financial Summary Report ---\n")
    sal_cols, sal_rows = make_selection("SELECT SUM(yearly_salary) FROM player_details")
    total_salary = float(sal_rows[0][0]) if sal_rows and sal_rows[0][0] is not None else 0.00
    print(f"Total Player Salary Expenditure: ${total_salary:,.2f}")
    
    sponsor_cols, sponsor_rows = make_selection("SELECT SUM(contribution) FROM club_sponsors")
    total_sponsorship = float(sponsor_rows[0][0]) if sponsor_rows and sponsor_rows[0][0] is not None else 0.00
    print(f"Total Yearly Sponsorship Income: ${total_sponsorship:,.2f}")
    
    expense_cols, expense_rows = make_selection("SELECT SUM(amount) FROM club_expenses")
    total_expense = float(expense_rows[0][0]) if expense_rows and expense_rows[0][0] is not None else 0.00
    print(f"Total Other Club Expenses: ${total_expense:,.2f}")
    
    revenue_cols, revenue_rows = make_selection("SELECT SUM(amount) FROM club_revenue")
    total_revenue = float(revenue_rows[0][0]) if revenue_rows and revenue_rows[0][0] is not None else 0.00
    print(f"Total Operational Revenue (excluding sponsors): ${total_revenue:,.2f}")
    
    net_income = (total_sponsorship + total_revenue) - (total_salary + total_expense)
    print("\n-------------------------------------------")
    print(f"NET FINANCIAL POSITION: ${net_income:,.2f}")
    print("-------------------------------------------\n")
    
    folder_name = f'Finance_Report_{datetime.now().strftime("%Y%m%d")}'
    os.makedirs(folder_name, exist_ok=True)
    print("Exporting detailed finance tables to CSV...")
    for table_name in ['player_details', 'club_revenue', 'club_sponsors', 'club_expenses']:
        export_table(table_name)  
        # Fix: Use os.path.join for cross-platform path handling
        try:
            os.replace(f"{table_name}.csv", os.path.join(folder_name, f"{table_name}.csv"))
            print(f" - {table_name}.csv exported successfully.")
        except FileNotFoundError:
            # Handles case where export_table failed (e.g. empty table with no columns)
            print(f" - {table_name}.csv not found, likely empty or export failed.")
    print("\nFinancial Summary Report complete. Detailed CSV files are in the", folder_name, "folder.")

#-----------------------------#
#      DEVELOPER ACTIONS      #
#-----------------------------#

def export_all_tables():
    exp_name = input("Export Name: ")
    print("Exporting entire database...")
    export_database(exp_name)
    print("Export finished.")

def import_from_csv():
    table = input("Table name to restore: ").strip()
    if (table,) not in make_selection("SHOW TABLES")[1]:
        print('Table "{table}" does not exist')
        return
    column, row = make_selection(f"SELECT * FROM {table}")
    if not column:
        print(f'Table "{table}" has no columns.')
        return
    filename = input("CSV filename (in current directory): ").strip()
    if not os.path.exists(filename):
        print(f"File '{filename}' not found.")
        return
    try:
        with open(filename, 'r', newline='') as file:
            reader = csv.reader(file)
            headers = next(reader)
            cols = ', '.join(headers)
            placeholders = ', '.join(['%s'] * len(headers))

            conn = make_connection()
            cursor = conn.cursor()
            count = 0
            for row in reader:
                cursor.execute(f"INSERT INTO {table} ({cols}) VALUES ({placeholders})",
                            tuple(None if c.strip() == '' else c for c in row)) #Converts blank cells '' to NULL
                count += 1
            conn.commit()
            cursor.close(); conn.close()
            print(f"Imported {count} rows into '{table}'.")
    except Exception as e:
        print("Import failed:", e)

def update_auth_data():
    logid = input("Login ID to update: ")
    if not make_selection("SELECT login_id FROM club_auth_data WHERE login_id = %s", (logid,))[1]:
        print("Invalid Login ID")
        return
    field = input("Field to update (Name/ Password/ Role): ").strip().lower()
    if field not in ('name', 'password', 'role'):
        print("Invalid Field")
        return
    value = input (f"New value for {field.title()}: ")
    
    if field == 'role' and value not in ['Player', 'Coaching Staff', 'Manager', 'Developer']:
        print("Invalid Role. Updatation Cancelled.")
        print("Try choosing (Player / Coaching Staff / Manager / Developer) for Role.")
        return

    make_entry(f"UPDATE club_auth_data SET {field} = %s WHERE login_id = %s",(value, logid))       
    print(f"'{field.title()}' successfully updated to '{value}'")

#------------------------#
#   ADDITIONAL ACTIONS   #
#------------------------#

def list_top_scorers():
    try:
        limit = int(input("How many top scorers to list: "))
    except ValueError:
        print("Invalid input. Limit must be an integer.")
        return


    cols, rows = make_selection("SELECT player_id, player_name, goals FROM player_stats_club ORDER BY goals DESC LIMIT %s", (limit,))
    if not rows:
        print("No stats available.")
        return
    table = PrettyTable(cols)
    table.add_rows(rows)
    print(f'\n--- Top {limit} scorers ----\n',table)

def list_injured_players():
    # Fix: Removed redundant JOIN to injury_log, player_details availability is sufficient
    cols, rows = make_selection("SELECT player_id, name, position FROM player_details WHERE availability = 'Injured'")
    if not rows:
        print("No injured players.")
        return
    
    # For more detail, join to injury_log
    cols, rows = make_selection("""SELECT pd.name, pd.position, i.injury_type, i.injury_date, i.expected_recovery_date, i.severity 
                                   FROM player_details pd JOIN injury_log i ON pd.player_id = i.player_id 
                                   WHERE pd.availability = 'Injured' ORDER BY i.injury_date DESC""")
                                   
    if not rows:
        # If the JOIN failed but players were marked 'Injured', this is a fallback
        print("No injury records found for players marked 'Injured'.")
        return
    
    table = PrettyTable(cols)
    table.add_rows(rows)
    print(f'\n--- Injured Players ----\n',table)

def add_fixture():
    mid = input("Match ID: ").strip()
    if make_selection("SELECT match_id FROM club_fixtures WHERE match_id = %s", (mid,))[1]:
        print(f"Error: Match ID '{mid}' already exists.")
        return
    opponent = input("Opponent name: ").strip()
    mdate = input("Match date (YYYY-MM-DD): ").strip()
    mtime = input("Match time (HH:MM:SS) optional: ").strip() 
    venue = input("Venue: ").strip() 
    tournament = input("Tournament: ").strip() 
    status = input("Status (Upcoming/Completed/Postponed): ").strip().title() or 'Upcoming'
    
    make_entry("INSERT INTO club_fixtures VALUES (%s,%s,%s,%s,%s,%s,%s)",(mid, opponent, mdate, mtime, venue, tournament, status))
    print("Fixture added. (Note: Date/Time format must be correct for successful entry)")

def record_match_history():
    print("\n--- Record Match History ---\n")
    mid = input("Match ID to complete: ").strip()

    if not make_selection("SELECT match_id FROM club_fixtures WHERE match_id = %s", (mid,))[1]:
        print(f"Error: Match ID '{mid}' not found in club fixtures.")
        return
    if make_selection("SELECT match_id FROM match_history WHERE match_id = %s", (mid,))[1]:
        print("Data for this Match ID has already been recorded")
        return
    date_played, opponent, tournament = make_selection ("SELECT match_date, opponent_name, tournament FROM club_fixtures WHERE match_id = %s",(mid,))[1][0]
    result = input("Result (Win/Loss/Draw): ").strip().title()
    if result not in ('Win','Loss','Draw'):
        print("Invalid result. Match not recorded.")
        return

    try:
        goals_scored = int(input("Goals scored: "))
        goals_conceded = int(input("Goals conceded: "))
        possession = float(input("Possession percent (e.g. 55.50): "))
        passes_str = input("Passes completed (int): ").strip()
        passes = int(passes_str) if passes_str else None # Fix: passes_completed is INT in DB
        fouls = int(input("Fouls committed: ").strip())
        yc = int(input("Yellow cards: ").strip())
        rc = int(input("Red cards: ").strip())
    except ValueError:
        print("Error: Goals, Possession, Fouls, and Cards must be numbers. Match not recorded.")
        return

    make_entry("INSERT INTO match_history  VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(mid, date_played, opponent, tournament, goals_scored, goals_conceded, possession , passes, fouls, yc, rc, result))
    # Update status in club_fixtures, and update the match_date in case it was a rescheduled match
    make_entry("UPDATE club_fixtures SET status = 'Completed', match_date = %s WHERE match_id = %s", (date_played, mid))
    print("Match recorded in history and fixture marked Completed.")

# ------------------------#
#      UI & MENUS         #
# ------------------------#

def print_header(title):
    """Prints a formatted header for menus and sections."""
    print("\n"+"=" * 50)
    print(f"{' ' * ((50 - len(title)) // 2)}{title.upper()}")
    print("=" * 50)

def player_menu(user_name, user_role):
    # The original code's logic here is fine, but needs to use the passed user_name
    rows = make_selection("SELECT player_id FROM player_details WHERE name = %s", (user_name,))[1]
    if not rows:
        print("No linked player profile found for this login.")
        return
    player_id = rows[0][0]
    while True:
        print_header(f"Player Dashboard | {user_name}")
        print("--- My Profile & Stats ---")
        print("1. View My Profile")
        print("2. Edit My Profile (Basic Info)")
        print("3. View My Career Stats")
        print("4. View My Current Season Stats")
        print("5. View My Recent Match Performance")
        print("6. View My Injury History")
        print("7. View My Training Schedule")
        print("\n--- Club & Squad Information ---")
        print("8. List All Players")
        print("9. Search for a Player")
        print("10. View Upcoming Matches")
        print("11. View Top Goal Scorers")
        print("12. View Injury List")
        print("\n0. Logout")
        
        choice = input("\nEnter your choice: ").strip()
        if choice == '1': view_profile(player_id)
        elif choice == '2': edit_profile(player_id)
        elif choice == '3': view_club_stats(player_id)
        elif choice == '4': view_season_stats(player_id)
        elif choice == '5': view_recent_match_performance(player_id)
        elif choice == '6': view_injury_history(player_id)
        elif choice == '7': view_training_schedule(player_id)
        elif choice == '8': list_players()
        elif choice == '9': search_player()
        elif choice == '10': view_upcoming_matches()
        elif choice == '11': list_top_scorers()
        elif choice == '12': list_injured_players()
        elif choice == '0': break
        else: print("\nInvalid choice.")

def coach_menu(user_name, user_role):
    # Fix: Renamed coach_name to user_name
    while True:
        print_header(f"Coaching Staff Dashboard | {user_name}")
        print("--- Player & Training Management ---")
        print("1. List All Players")
        print("2. Search for a Player")
        print("3. Assign Training Schedule")
        print("4. Update Training Schedule")
        print("5. Record Player Injury")
        print("\n--- Match Management & Analytics ---")
        print("6. View Upcoming Matches")
        print("7. Record Completed Match Result")
        print("8. Record Post-Match Player Performance")
        print("9. List Top Goal Scorers")
        print("10. View Injury List")
        print("\n0. Logout")
        
        choice = input("\nEnter your choice: ").strip()
        if choice == '1': list_players()
        elif choice == '2': search_player()
        elif choice == '3': assign_training()
        elif choice == '4': update_training()
        elif choice == '5': record_injury()
        elif choice == '6': view_upcoming_matches()
        elif choice == '7': record_match_history()
        elif choice == '8': record_post_match_performance()
        elif choice == '9': list_top_scorers()
        elif choice == '10': list_injured_players()
        elif choice == '0': break
        else: print("\nInvalid choice.")

def manager_menu(user_name, user_role):
    # Fix: Renamed manager_name to user_name
    while True:
        print_header(f"Manager Dashboard | {user_name}")
        print("--- Squad Management ---")
        print("1. List All Players (Full Details)")
        print("2. Search for a Player (Full Details)")
        print("3. Add New Player")
        print("4. Remove Player")
        print("5. Renew Player Contract")
        print("6. Suspend Player")
        print("7. Lift Player Suspension")
        print("\n--- Financial Management ---")
        print("8. Record Club Revenue")
        print("9. Record Club Expense")
        print("10. Add New Sponsorship Deal")
        print("11. View Financial Tables")
        print("12. Generate Financial Summary Report")
        print("\n--- Fixtures & Analytics ---")
        print("13. Add New Fixture")
        print("14. Record Completed Match Result")
        print("15. View Upcoming Matches")
        print("16. List Top Goal Scorers")
        print("17. View Injury List")
        print("\n0. Logout")
        
        choice = input("\nEnter your choice: ").strip()
        if choice == '1': list_players(show_finance=True)
        elif choice == '2': search_player(show_finance=True)
        elif choice == '3': add_new_player()
        elif choice == '4': remove_player()
        elif choice == '5': contract_renewal()
        elif choice == '6': suspend_player()
        elif choice == '7': unsuspend_player()
        elif choice == '8': record_club_revenue()
        elif choice == '9': record_club_expense()
        elif choice == '10': add_new_sponsorship()
        elif choice == '11': view_finance()
        elif choice == '12': generate_financial_report()
        elif choice == '13': add_fixture()
        elif choice == '14': record_match_history()
        elif choice == '15': view_upcoming_matches()
        elif choice == '16': list_top_scorers()
        elif choice == '17': list_injured_players()
        elif choice == '0': break
        else: print("\n[Error] Invalid choice.")
        
def developer_menu(user_name, user_role):
    # Fix: Removed press_enter_to_continue call since it's not defined
    while True:
        print_header(f"Developer Console | {user_name}")
        print("--- System & Data Management ---")
        print("1. Export Entire Database to CSV")
        print("2. Restore Table from CSV")
        print("3. Update User Authentication Data")
        print("\n0. Logout")
        
        choice = input("\nEnter your choice: ").strip()
        if choice == '1': export_all_tables()
        elif choice == '2': import_from_csv()
        elif choice == '3': update_auth_data()
        elif choice == '0': break
        else: print("\n[Error] Invalid choice.")

def main_menu():
    while True:
        print_header("Football Team Management System")
        print("1. Login")
        print("2. Register New User")
        print("3. Exit")
        choice = input("\nEnter your choice: ").strip()
        
        if choice == '1':
            user_name, role = login_user() # Fix: Correctly capture the return values
            if user_name is not None:
                if role == 'Player': player_menu(user_name, role)
                elif role == 'Coaching Staff': coach_menu(user_name, role)
                elif role == 'Manager': manager_menu(user_name, role)
                elif role == 'Developer': developer_menu(user_name, role)
        elif choice == '2':
            register_user()
        elif choice == '3':
            print("\nThank you for using the system. Goodbye!")
            sys.exit(0)
        else:
            print("\nInvalid choice. Please try again.")

# ------------------------#
#     MAIN EXECUTION      #
# ------------------------#

if __name__ == "__main__":
    main_menu()
