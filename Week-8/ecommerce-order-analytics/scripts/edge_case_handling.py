import pandas as pd
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"


def test_invalid_order_reference():

    orders = pd.read_csv(RAW / "orders.csv")
    items = pd.read_csv(RAW / "order_items.csv")

    known_orders = set(orders["order_id"])

    invalid = items[
        ~items["order_id"].isin(known_orders)
    ]

    print("\nTest 1 - Invalid Order ID")
    print("Invalid references:", len(invalid))

    return len(invalid)


def test_discount_limit():

    items = pd.read_csv(RAW / "order_items.csv")

    invalid = items[
        (items["discount_percent"] < 0) |
        (items["discount_percent"] > 100)
    ]

    print("\nTest 2 - Invalid Discount")
    print("Invalid rows:", len(invalid))

    return len(invalid)


def test_zero_quantity():

    items = pd.read_csv(RAW / "order_items.csv")

    zero_rows = items[
        items["quantity"] == 0
    ]

    print("\nTest 3 - Zero Quantity")
    print("Rows with zero quantity:", len(zero_rows))

    return len(zero_rows)


def test_future_dates():

    orders = pd.read_csv(
        RAW / "orders.csv"
    )

    dates = pd.to_datetime(
        orders["order_date"],
        errors="coerce",
        dayfirst=True
    )

    future = orders[
        dates > pd.Timestamp.now()
    ]

    print("\nTest 4 - Future Order Date")
    print("Future dated orders:", len(future))

    return len(future)


def run_tests():

    print("=" * 55)
    print("EDGE CASE VALIDATION")
    print("=" * 55)

    test_invalid_order_reference()
    test_discount_limit()
    test_zero_quantity()
    test_future_dates()

    print("\nAll edge-case checks completed.")


if __name__ == "__main__":
    run_tests()