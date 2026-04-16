# algorithm_lab.py
# ============================================
# ALGORITHM LAB
# by: <Your Name>
# ============================================

menu = [
    {"name": "Adobo",       "price": 60,  "rating": 4.5},
    {"name": "Sinigang",    "price": 65,  "rating": 4.8},
    {"name": "Bistek",      "price": 70,  "rating": 4.3},
    {"name": "Tinola",      "price": 55,  "rating": 4.1},
    {"name": "Kare-Kare",   "price": 95,  "rating": 4.9},
    {"name": "Tortang Talong", "price": 45, "rating": 4.0},
    {"name": "Turon",       "price": 20,  "rating": 4.4},
    {"name": "Halo-Halo",   "price": 60,  "rating": 4.7},
    {"name": "Buko Juice",  "price": 25,  "rating": 4.2},
    {"name": "Lumpia",      "price": 35,  "rating": 4.6},
]

print("=" * 50)
print("  ALGORITHM LAB")
print("=" * 50)

# TODO: Task 1 — Bubble sort by price
# Use nested for loops. Count swaps.


# TODO: Task 2 — Python's built-in sort
# Use sorted(menu, key=lambda x: x["price"])


# TODO: Task 3 — Combo finder
# def find_best_combo(menu, budget):
#     Try every pair, return highest-rated combo within budget


# TODO: Task 4 — Linear search
# def linear_search(menu, target_name):
#     for item in menu: check name


# TODO: Task 5 — Binary search
# def binary_search(sorted_menu, target_name):
#     low=0, high=len-1, repeatedly halve the range
