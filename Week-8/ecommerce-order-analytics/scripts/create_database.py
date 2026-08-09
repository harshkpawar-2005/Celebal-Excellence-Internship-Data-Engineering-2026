import sqlite3
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

DB_DIR = ROOT / "database"
DATA_DIR = ROOT / "data" / "cleaned"

DB_DIR.mkdir(exist_ok=True)

DB_PATH = DB_DIR / "ecommerce.db"

connection = sqlite3.connect(DB_PATH)
cursor = connection.cursor()

# Recreate tables
cursor.executescript("""
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER,
    customer_name TEXT,
    email TEXT,
    registration_date TEXT,
    customer_type TEXT
);

CREATE TABLE products (
    product_id INTEGER,
    product_name TEXT,
    category TEXT,
    subcategory TEXT,
    cost_price REAL
);

CREATE TABLE orders (
    order_id INTEGER,
    customer_id INTEGER,
    order_date TEXT,
    status TEXT,
    region_code TEXT
);

CREATE TABLE order_items (
    item_id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price REAL,
    discount_percent REAL
);
""")


def load_csv(filename, table, columns):
    file_path = DATA_DIR / filename

    with open(file_path, "r", encoding="utf-8-sig", newline="") as file:
        reader = csv.reader(file)
        next(reader)

        placeholders = ",".join(["?"] * len(columns))

        cursor.executemany(
            f"""
            INSERT INTO {table} ({",".join(columns)})
            VALUES ({placeholders})
            """,
            reader
        )

    print(f"Loaded {filename} → {table}")


load_csv(
    "cleaned_customers.csv",
    "customers",
    [
        "customer_id",
        "customer_name",
        "email",
        "registration_date",
        "customer_type"
    ]
)

load_csv(
    "cleaned_products.csv",
    "products",
    [
        "product_id",
        "product_name",
        "category",
        "subcategory",
        "cost_price"
    ]
)

load_csv(
    "cleaned_orders.csv",
    "orders",
    [
        "order_id",
        "customer_id",
        "order_date",
        "status",
        "region_code"
    ]
)

load_csv(
    "cleaned_order_items.csv",
    "order_items",
    [
        "item_id",
        "order_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount_percent"
    ]
)


connection.commit()

print("\nDatabase created successfully!")
print(f"Location: {DB_PATH}")

for table in ["customers", "products", "orders", "order_items"]:
    cursor.execute(f"SELECT COUNT(*) FROM {table}")
    count = cursor.fetchone()[0]
    print(f"{table}: {count} rows")

connection.close()