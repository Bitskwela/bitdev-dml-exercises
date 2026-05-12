# Carinderia Ordering System

Build a complete carinderia ordering system using lists, dictionaries, loops, and conditionals — the building blocks of every Python program.

---

## Task 1: Build the Menu

Open `act_1.py` and define a `menu` list of at least 8 dictionaries. Each dish should have:
- `name` (string)
- `price` (int)
- `category` (string: "main", "side", "dessert", or "drink")

### Suggested Menu

| Item | Price | Category |
|------|-------|----------|
| Adobo + Rice | 60 | main |
| Sinigang + Rice | 65 | main |
| Bistek + Rice | 70 | main |
| Tortang Talong | 45 | side |
| Turon | 20 | dessert |
| Halo-Halo | 60 | dessert |
| Buko Juice | 25 | drink |

---

## Task 2: Display the Menu

Write a `display_menu()` function that groups items by category using a dictionary, then prints them in a readable format.

---

## Task 3: Ordering Loop

Build a `while True:` loop that:
- Displays the menu
- Asks for an item number (or `done` / `q`)
- Uses `try/except` to handle invalid input
- Asks for quantity
- Tracks running total

---

## Task 4: Senior Discount + Receipt

After ordering:
- Ask if customer is a senior (apply 20% discount)
- Print a formatted receipt with subtotal, discount, total

---

## Task 5: Order Statistics

Count items by category and print a breakdown.

### Sample Output

```
=== RECEIPT — Tita Malou's Carinderia ===
   2x Adobo + Rice              P 120.00
   1x Halo-Halo                 P  60.00
------------------------------------------
                       Subtotal P 180.00
                          TOTAL P 180.00

📊 Order stats:
   Total items: 3
   desserts: 1
   mains: 2
```

---

## Challenge: Multi-Customer Tracking

Extend the system to handle multiple customers in a single session:
- Wrap the ordering loop in another `while True:` for "next customer"
- Track ALL customers' orders in `all_orders`
- At end of day, show:
  - Total customers served
  - Total revenue across all orders
  - Top 3 best-selling items

---

## What You've Learned

- Lists, dictionaries, and lists of dictionaries
- For loops and while loops
- If/elif/else conditionals
- `try/except` for error handling
- String methods (strip, lower, split)
- f-string alignment for formatted output

Next up: **Working with Libraries** — Dan meets numpy and pandas.
