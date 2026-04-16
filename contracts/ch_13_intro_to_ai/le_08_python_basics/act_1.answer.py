# carinderia_ordering.py
# ============================================
# CARINDERIA ORDERING SYSTEM — Full Solution
# by Dan Santos
# ============================================

print("=" * 50)
print("  TITA MALOU'S CARINDERIA")
print("  Welcome! Tara, kain tayo!")
print("=" * 50)

menu = [
    {"name": "Adobo + Rice",        "price": 60, "category": "main"},
    {"name": "Sinigang + Rice",     "price": 65, "category": "main"},
    {"name": "Bistek + Rice",       "price": 70, "category": "main"},
    {"name": "Tinola + Rice",       "price": 55, "category": "main"},
    {"name": "Kare-Kare + Rice",    "price": 95, "category": "main"},
    {"name": "Tortang Talong",      "price": 45, "category": "side"},
    {"name": "Lumpia (3pcs)",       "price": 35, "category": "side"},
    {"name": "Turon",               "price": 20, "category": "dessert"},
    {"name": "Halo-Halo",           "price": 60, "category": "dessert"},
    {"name": "Buko Juice",          "price": 25, "category": "drink"},
    {"name": "Iced Tea",            "price": 20, "category": "drink"},
    {"name": "Kape",                "price": 15, "category": "drink"},
]


def display_menu():
    """Print the menu organized by category."""
    print("\n--- MENU ---")
    categories = {}
    for item in menu:
        categories.setdefault(item["category"], []).append(item)

    for cat in ["main", "side", "dessert", "drink"]:
        if cat in categories:
            print(f"\n  {cat.upper()}S")
            for i, item in enumerate(menu):
                if item["category"] == cat:
                    print(f"    {i+1:2d}. {item['name']:25} P{item['price']}")


# Main ordering loop
order = []
running_total = 0

print("\nType the item number to order, 'done' to finish, or 'q' to cancel.")

while True:
    display_menu()
    choice = input("\nYour choice: ").strip().lower()

    if choice == "q":
        print("Order cancelled. Salamat!")
        break

    if choice == "done":
        if not order:
            print("No items ordered yet. Pick something or 'q' to quit.")
            continue
        break

    try:
        index = int(choice) - 1
        if index < 0 or index >= len(menu):
            print(f"Please enter 1-{len(menu)}.")
            continue
    except ValueError:
        print("Invalid input. Type a number, 'done', or 'q'.")
        continue

    qty_input = input(f"How many {menu[index]['name']}? ").strip()
    try:
        qty = int(qty_input)
        if qty <= 0:
            print("Quantity must be positive.")
            continue
    except ValueError:
        print("Quantity must be a number.")
        continue

    item = menu[index]
    subtotal = item["price"] * qty
    order.append({"name": item["name"], "qty": qty, "subtotal": subtotal, "category": item["category"]})
    running_total += subtotal
    print(f"   ✓ Added {qty}x {item['name']} = P{subtotal}")
    print(f"   Running total: P{running_total}")

# Senior discount
if order:
    is_senior = input("\nSenior citizen? (yes/no): ").strip().lower() == "yes"
    discount = 0
    if is_senior:
        discount = round(running_total * 0.20, 2)

    # Receipt
    print("\n" + "=" * 50)
    print("  RECEIPT — Tita Malou's Carinderia")
    print("=" * 50)
    for o in order:
        print(f"  {o['qty']:>2}x {o['name']:25} P{o['subtotal']:>7.2f}")
    print("-" * 50)
    print(f"  {'Subtotal':>30} P{running_total:>7.2f}")
    if is_senior:
        print(f"  {'Senior discount (20%)':>30} -P{discount:>6.2f}")
    final = running_total - discount
    print(f"  {'TOTAL':>30} P{final:>7.2f}")
    print("=" * 50)

    # Statistics
    cat_breakdown = {}
    for o in order:
        cat_breakdown[o["category"]] = cat_breakdown.get(o["category"], 0) + o["qty"]
    total_items = sum(o["qty"] for o in order)

    print(f"\n📊 Order stats:")
    print(f"   Total items: {total_items}")
    for cat, count in sorted(cat_breakdown.items()):
        print(f"   {cat}s: {count}")

    if final > 500:
        print("\n   🏆 Big order! Salamat sa pagsuporta!")
    elif final > 200:
        print("\n   👍 Solid order!")
    else:
        print("\n   🙂 Salamat! Balik kayo!")
