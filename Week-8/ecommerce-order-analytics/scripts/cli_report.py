import sqlite3
from datetime import datetime, timedelta
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "database" / "ecommerce.db"


def read_date(message):

    while True:

        value = input(message).strip()

        try:
            return datetime.strptime(
                value,
                "%Y-%m-%d"
            ).date()

        except ValueError:
            print("Please enter date as YYYY-MM-DD.")


def calculate_previous_period(start, end):

    period_length = (end - start).days + 1

    previous_end = start - timedelta(days=1)

    previous_start = (
        previous_end -
        timedelta(days=period_length - 1)
    )

    return previous_start, previous_end


def percentage_change(current, previous):

    if previous == 0:
        return None

    return round(
        ((current - previous) / previous) * 100,
        2
    )


def fetch_summary(cursor, start, end):

    query = """
        SELECT
            COUNT(DISTINCT o.order_id),
            COALESCE(
                ROUND(
                    SUM(
                        oi.quantity *
                        oi.unit_price *
                        (1 - oi.discount_percent / 100.0)
                    ),
                    2
                ),
                0
            ),
            COUNT(DISTINCT o.customer_id)
        FROM orders o
        JOIN order_items oi
            ON oi.order_id = o.order_id
        WHERE date(o.order_date)
              BETWEEN ? AND ?
          AND o.customer_id != -1
          AND oi.quantity > 0;
    """

    cursor.execute(
        query,
        (start.isoformat(), end.isoformat())
    )

    return cursor.fetchone()


def fetch_top_products(cursor, start, end):

    query = """
        SELECT
            p.product_name,
            SUM(oi.quantity) AS units_sold
        FROM products p
        JOIN order_items oi
            ON oi.product_id = p.product_id
        JOIN orders o
            ON o.order_id = oi.order_id
        WHERE date(o.order_date)
              BETWEEN ? AND ?
          AND oi.quantity > 0
        GROUP BY p.product_id, p.product_name
        ORDER BY units_sold DESC
        LIMIT 3;
    """

    cursor.execute(
        query,
        (start.isoformat(), end.isoformat())
    )

    return cursor.fetchall()


def display_report(
    report_type,
    start,
    end,
    current,
    previous,
    products
):

    orders, revenue, customers = current
    old_orders, old_revenue, old_customers = previous

    print("\n" + "=" * 55)
    print("E-COMMERCE ORDER REPORT")
    print("=" * 55)

    print(f"Report Type : {report_type}")
    print(f"Period      : {start} to {end}")

    print("\nSUMMARY")
    print("-" * 55)
    print(f"Total Orders     : {orders}")
    print(f"Revenue          : {revenue:.2f}")
    print(f"Unique Customers : {customers}")

    print("\nTOP 3 PRODUCTS")
    print("-" * 55)

    if products:
        for position, (name, quantity) in enumerate(products, 1):
            print(f"{position}. {name} ({quantity} units)")
    else:
        print("No product sales found.")

    print("\nPREVIOUS PERIOD COMPARISON")
    print("-" * 55)

    changes = [
        ("Orders", orders, old_orders),
        ("Revenue", revenue, old_revenue),
        ("Customers", customers, old_customers)
    ]

    for label, current_value, previous_value in changes:

        change = percentage_change(
            current_value,
            previous_value
        )

        text = "N/A" if change is None else f"{change}%"

        print(f"{label:<15}: {text}")


def main():

    if not DB_PATH.exists():
        print(f"Database not found: {DB_PATH}")
        return

    report_type = input(
        "Enter report type (daily/weekly/monthly): "
    ).strip().lower()

    if report_type not in {"daily", "weekly", "monthly"}:
        print("Invalid report type.")
        return

    start = read_date(
        "Enter start date (YYYY-MM-DD): "
    )

    end = read_date(
        "Enter end date (YYYY-MM-DD): "
    )

    if end < start:
        print("End date cannot be before start date.")
        return

    previous_start, previous_end = calculate_previous_period(
        start,
        end
    )

    with sqlite3.connect(DB_PATH) as connection:

        cursor = connection.cursor()

        current_summary = fetch_summary(
            cursor,
            start,
            end
        )

        previous_summary = fetch_summary(
            cursor,
            previous_start,
            previous_end
        )

        top_products = fetch_top_products(
            cursor,
            start,
            end
        )

    display_report(
        report_type,
        start,
        end,
        current_summary,
        previous_summary,
        top_products
    )


if __name__ == "__main__":
    main()