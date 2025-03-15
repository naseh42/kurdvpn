import sqlite3

class UserManager:
    def __init__(self, db_path="kurdan.db"):
        self.db_path = db_path
        self.create_table()

    def create_table(self):
        with sqlite3.connect(self.db_path) as conn:
            conn.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    username TEXT UNIQUE,
                    password TEXT,
                    data_limit INTEGER,
                    expiry_date TEXT
                )
            """)

    def add_user(self, username, password, data_limit, expiry_date):
        with sqlite3.connect(self.db_path) as conn:
            conn.execute("INSERT INTO users (username, password, data_limit, expiry_date) VALUES (?, ?, ?, ?)",
                         (username, password, data_limit, expiry_date))

    def list_users(self):
        with sqlite3.connect(self.db_path) as conn:
            return conn.execute("SELECT * FROM users").fetchall()

    def delete_user(self, username):
        with sqlite3.connect(self.db_path) as conn:
            conn.execute("DELETE FROM users WHERE username = ?", (username,))

# تست
if __name__ == "__main__":
    manager = UserManager()
    manager.add_user("test_user", "pass123", 10, "2025-12-31")
    print(manager.list_users())