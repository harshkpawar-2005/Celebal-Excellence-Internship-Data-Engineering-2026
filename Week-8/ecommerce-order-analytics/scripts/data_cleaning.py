import pandas as pd
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
CLEAN = ROOT / "data" / "cleaned"
REPORT = ROOT / "reports"

CLEAN.mkdir(parents=True, exist_ok=True)
REPORT.mkdir(parents=True, exist_ok=True)


def clean_orders():

    df = pd.read_csv(RAW / "orders.csv")

    original_missing = df["customer_id"].isna().sum()

    # Replace missing customer IDs with -1
    df["customer_id"] = df["customer_id"].fillna(-1)

    # Parse both normal and DD-MM-YYYY values
    df["order_date"] = pd.to_datetime(
        df["order_date"],
        errors="coerce",
        dayfirst=True
    )

    invalid_dates = df["order_date"].isna().sum()

    df["order_date"] = df["order_date"].dt.strftime(
        "%Y-%m-%d %H:%M:%S"
    )

    df.to_csv(
        CLEAN / "orders_cleaned.csv",
        index=False
    )

    return {
        "missing_customer_ids": int(original_missing),
        "invalid_dates": int(invalid_dates)
    }


def clean_products():

    df = pd.read_csv(RAW / "products.csv")

    changed_names = 0

    for index, value in df["product_name"].items():

        normalized = " ".join(str(value).split()).title()

        if normalized != value:
            changed_names += 1

        df.at[index, "product_name"] = normalized

    df.to_csv(
        CLEAN / "products_cleaned.csv",
        index=False
    )

    return {
        "normalized_product_names": changed_names
    }


def validate_emails():

    df = pd.read_csv(RAW / "customers.csv")

    pattern = r"^[^@\s]+@[^@\s]+\.[^@\s]+$"

    invalid_ids = []

    for _, row in df.iterrows():

        email = str(row["email"]).strip()

        if not re.match(pattern, email):
            invalid_ids.append(row["customer_id"])

    # Keep the customer file as part of the cleaned output
    df.to_csv(
        CLEAN / "customers_cleaned.csv",
        index=False
    )

    return invalid_ids


def check_referential_integrity():

    orders = pd.read_csv(RAW / "orders.csv")
    items = pd.read_csv(RAW / "order_items.csv")

    valid_order_ids = set(orders["order_id"])

    broken = items[
        ~items["order_id"].isin(valid_order_ids)
    ]

    items.to_csv(
        CLEAN / "order_items_cleaned.csv",
        index=False
    )

    return broken


def write_report(order_info, product_info, invalid_emails, broken_refs):

    report_path = REPORT / "data_quality_report.txt"

    with open(report_path, "w", encoding="utf-8") as report:

        report.write("DATA QUALITY REPORT\n")
        report.write("=" * 60 + "\n\n")

        report.write("ORDERS\n")
        report.write("-" * 60 + "\n")
        report.write(
            f"Missing customer IDs: "
            f"{order_info['missing_customer_ids']}\n"
        )
        report.write(
            f"Invalid dates after parsing: "
            f"{order_info['invalid_dates']}\n\n"
        )

        report.write("PRODUCTS\n")
        report.write("-" * 60 + "\n")
        report.write(
            f"Names normalized: "
            f"{product_info['normalized_product_names']}\n\n"
        )

        report.write("CUSTOMERS\n")
        report.write("-" * 60 + "\n")
        report.write(
            f"Invalid emails: {len(invalid_emails)}\n"
        )

        if invalid_emails:
            report.write(
                "Customer IDs: "
                + ", ".join(map(str, invalid_emails))
                + "\n"
            )

        report.write("\nORDER ITEMS\n")
        report.write("-" * 60 + "\n")
        report.write(
            f"Broken order references: {len(broken_refs)}\n"
        )

    print(f"Report created: {report_path}")


def main():

    order_results = clean_orders()
    product_results = clean_products()
    invalid_emails = validate_emails()
    broken_references = check_referential_integrity()

    write_report(
        order_results,
        product_results,
        invalid_emails,
        broken_references
    )

    print("Cleaning and validation completed.")


if __name__ == "__main__":
    main()