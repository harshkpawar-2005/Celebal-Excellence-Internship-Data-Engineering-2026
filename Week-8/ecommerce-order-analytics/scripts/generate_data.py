from faker import Faker
import pandas as pd
import random
from pathlib import Path

# -----------------------------
# Configuration
# -----------------------------

SEED = 42
CUSTOMER_COUNT = 700
PRODUCT_COUNT = 500
ORDER_COUNT = 2000
ITEM_COUNT = 5500

random.seed(SEED)
Faker.seed(SEED)

fake = Faker()

BASE_DIR = Path(__file__).resolve().parents[1]
RAW_DIR = BASE_DIR / "data" / "raw"
RAW_DIR.mkdir(parents=True, exist_ok=True)


# -----------------------------
# Customer generation
# -----------------------------

def build_customers():
    customer_types = ["REGULAR", "PREMIUM", "VIP"]
    records = []

    for number in range(1, CUSTOMER_COUNT + 1):
        records.append({
            "customer_id": number,
            "customer_name": fake.name(),
            "email": fake.email(),
            "registration_date": fake.date_between(
                start_date="-10y",
                end_date="today"
            ),
            "customer_type": random.choice(customer_types)
        })

    df = pd.DataFrame(records)

    # Introduce approximately 2% invalid emails
    bad_count = max(1, int(len(df) * 0.02))

    for idx in random.sample(list(df.index), bad_count):
        original = df.at[idx, "email"]

        if random.choice([True, False]):
            df.at[idx, "email"] = original.replace("@", "")
        else:
            df.at[idx, "email"] = original.split("@")[0] + "@"

    return df


# -----------------------------
# Product generation
# -----------------------------

PRODUCT_GROUPS = {
    "Electronics": {
        "Laptop": (35000, 120000),
        "Smartphone": (8000, 90000),
        "Tablet": (12000, 70000),
        "Monitor": (6000, 45000),
        "Keyboard": (500, 5000),
        "Mouse": (300, 3000),
        "Headphones": (800, 20000),
        "Smartwatch": (2000, 50000),
        "Printer": (5000, 35000),
        "Camera": (20000, 150000)
    },
    "Clothing": {
        "T-Shirt": (200, 2000),
        "Shirt": (400, 3500),
        "Jeans": (800, 5000),
        "Trousers": (700, 4500),
        "Jacket": (1500, 12000),
        "Hoodie": (1000, 6000),
        "Dress": (800, 8000),
        "Footwear": (1000, 10000),
        "Sportswear": (1000, 7000),
        "Accessories": (200, 4000)
    },
    "Home": {
        "Furniture": (3000, 80000),
        "Cookware": (500, 15000),
        "Kitchen Appliances": (1500, 60000),
        "Home Decor": (300, 20000),
        "Lighting": (500, 15000),
        "Storage": (200, 8000),
        "Bedding": (500, 12000),
        "Bathroom Accessories": (200, 6000),
        "Cleaning Supplies": (100, 3000),
        "Dining": (300, 10000)
    },
    "Books": {
        "Fiction": (200, 800),
        "Non-Fiction": (250, 1200),
        "Technology": (500, 3500),
        "Science": (400, 2500),
        "History": (300, 2000),
        "Biography": (250, 1800),
        "Self Help": (250, 1500),
        "Business": (300, 2500)
    },
    "Sports": {
        "Cricket": (300, 20000),
        "Football": (300, 15000),
        "Badminton": (500, 12000),
        "Gym Equipment": (1000, 80000),
        "Yoga": (300, 6000),
        "Cycling": (5000, 150000),
        "Swimming": (200, 10000),
        "Running": (500, 15000)
    }
}

PRODUCT_NAMES = {
    "Laptop": ["Dell Inspiron 15", "HP Pavilion 14", "Lenovo IdeaPad", "ASUS VivoBook"],
    "Smartphone": ["iPhone 15", "Samsung Galaxy", "OnePlus", "Google Pixel"],
    "Tablet": ["iPad Air", "Galaxy Tab", "Lenovo Tab", "OnePlus Pad"],
    "Monitor": ["Dell UltraSharp", "LG UltraGear", "Samsung Odyssey", "Acer Nitro"],
    "Keyboard": ["Logitech K380", "HP Wireless Keyboard", "Dell KB216", "Redragon K552"],
    "Mouse": ["Logitech M185", "Dell Optical Mouse", "HP Wireless Mouse", "Razer Mouse"],
    "Headphones": ["Sony WH Series", "JBL Tune", "Boat Rockerz", "Sennheiser HD"],
    "Smartwatch": ["Apple Watch", "Galaxy Watch", "Noise Watch", "Amazfit"],
    "Printer": ["HP LaserJet", "Canon PIXMA", "Epson EcoTank", "Brother Printer"],
    "Camera": ["Canon EOS", "Sony Alpha", "Nikon Z", "Fujifilm Camera"],
}

DEFAULT_NAMES = [
    "Premium Product",
    "Classic Product",
    "Everyday Product",
    "Professional Product",
    "Essential Product"
]


def build_products():
    rows = []

    categories = list(PRODUCT_GROUPS.keys())

    for product_id in range(1, PRODUCT_COUNT + 1):

        category = random.choice(categories)
        subcategory = random.choice(list(PRODUCT_GROUPS[category].keys()))

        low, high = PRODUCT_GROUPS[category][subcategory]

        names = PRODUCT_NAMES.get(subcategory, DEFAULT_NAMES)

        rows.append({
            "product_id": product_id,
            "product_name": random.choice(names),
            "category": category,
            "subcategory": subcategory,
            "cost_price": round(random.uniform(low, high), 2)
        })

    df = pd.DataFrame(rows)

    # Add spaces / mixed casing to approximately 5%
    affected = random.sample(
        list(df.index),
        max(1, int(len(df) * 0.05))
    )

    for idx in affected:
        value = df.at[idx, "product_name"]

        transformation = random.choice([
            lambda x: f"  {x}  ",
            lambda x: x.upper(),
            lambda x: x.lower()
        ])

        df.at[idx, "product_name"] = transformation(value)

    return df


# -----------------------------
# Order generation
# -----------------------------

def build_orders(customer_ids):
    statuses = [
        "PLACED",
        "SHIPPED",
        "DELIVERED",
        "CANCELLED",
        "RETURNED"
    ]

    regions = ["NORTH", "SOUTH", "EAST", "WEST", "CENTRAL"]

    rows = []

    for order_number in range(1, ORDER_COUNT + 1):
        rows.append({
            "order_id": order_number,
            "customer_id": random.choice(customer_ids),
            "order_date": fake.date_time_between(
                start_date="-2y",
                end_date="now"
            ).strftime("%Y-%m-%d %H:%M:%S"),
            "status": random.choice(statuses),
            "region_code": random.choice(regions)
        })

    df = pd.DataFrame(rows)

    # 5% missing customer IDs
    null_rows = random.sample(
        list(df.index),
        int(len(df) * 0.05)
    )
    df.loc[null_rows, "customer_id"] = None

    # Intentionally corrupt some dates
    date_rows = random.sample(
        list(df.index),
        int(len(df) * 0.05)
    )

    for idx in date_rows:
        parsed = pd.to_datetime(df.at[idx, "order_date"])
        df.at[idx, "order_date"] = parsed.strftime("%d-%m-%Y")

    return df


# -----------------------------
# Order item generation
# -----------------------------

def build_order_items(order_ids, products):
    rows = []

    product_lookup = products.set_index("product_id")["cost_price"].to_dict()

    for item_number in range(1, ITEM_COUNT + 1):

        product_id = random.choice(list(product_lookup.keys()))
        base_price = product_lookup[product_id]

        quantity = random.randint(1, 10)
        margin = random.uniform(0.10, 0.40)

        selling_price = round(
            base_price * (1 + margin),
            2
        )

        rows.append({
            "item_id": item_number,
            "order_id": random.choice(order_ids),
            "product_id": product_id,
            "quantity": quantity,
            "unit_price": selling_price,
            "discount_percent": random.randint(0, 99)
        })

    df = pd.DataFrame(rows)

    # 3% negative quantities = returns
    return_rows = random.sample(
        list(df.index),
        int(len(df) * 0.03)
    )

    df.loc[return_rows, "quantity"] *= -1

    return df


# -----------------------------
# Main generation pipeline
# -----------------------------

def save_dataset(frame, filename):
    destination = RAW_DIR / filename
    frame.to_csv(destination, index=False)
    print(f"Created: {destination}")


def main():

    customers = build_customers()
    products = build_products()
    orders = build_orders(customers["customer_id"].tolist())
    items = build_order_items(
        orders["order_id"].tolist(),
        products
    )

    save_dataset(customers, "customers.csv")
    save_dataset(products, "products.csv")
    save_dataset(orders, "orders.csv")
    save_dataset(items, "order_items.csv")

    print("\nGeneration completed.")
    print(f"Customers : {len(customers)}")
    print(f"Products  : {len(products)}")
    print(f"Orders    : {len(orders)}")
    print(f"Items     : {len(items)}")


if __name__ == "__main__":
    main()