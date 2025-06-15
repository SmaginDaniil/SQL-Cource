import sqlite3
import pandas as pd
import os

# Подключаемся к базе данных (создаст файл, если не существует)
conn = sqlite3.connect("shop.db")
cursor = conn.cursor()

# Путь к папке с CSV
csv_folder = "csv"

# Словарь: имя CSV → имя таблицы
tables = {
    "users.csv": "Users",
    "brands.csv": "Brands",
    "categories.csv": "Categories",
    "products.csv": "Products",
    "availability.csv": "Availability",
    "orders.csv": "Orders",
    "order_items.csv": "Order_Items",
    "reviews.csv": "Reviews",
}

# Импортируем все таблицы
for csv_file, table in tables.items():
    path = os.path.join(csv_folder, csv_file)
    print(f"Импортируем {csv_file} → {table}")
    df = pd.read_csv(path)
    df.to_sql(table, conn, if_exists="append", index=False)

print("✅ Импорт завершён.")
conn.close()
