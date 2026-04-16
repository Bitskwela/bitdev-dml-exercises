# algorithm_lab.py
# ============================================
# ALGORITHM LAB — Full Solution
# by Dan Santos
# ============================================

menu = [
    {"name": "Adobo",          "price": 60,  "rating": 4.5},
    {"name": "Sinigang",       "price": 65,  "rating": 4.8},
    {"name": "Bistek",         "price": 70,  "rating": 4.3},
    {"name": "Tinola",         "price": 55,  "rating": 4.1},
    {"name": "Kare-Kare",      "price": 95,  "rating": 4.9},
    {"name": "Tortang Talong", "price": 45,  "rating": 4.0},
    {"name": "Turon",          "price": 20,  "rating": 4.4},
    {"name": "Halo-Halo",      "price": 60,  "rating": 4.7},
    {"name": "Buko Juice",     "price": 25,  "rating": 4.2},
    {"name": "Lumpia",         "price": 35,  "rating": 4.6},
]

print("=" * 50)
print("  ALGORITHM LAB")
print("=" * 50)

# Task 1: Bubble Sort
print("\n-- Task 1: Bubble Sort by price --")
prices = [item["price"] for item in menu]
names = [item["name"] for item in menu]
n = len(prices)
swaps = 0
steps = 0
for i in range(n):
    for j in range(0, n - i - 1):
        steps += 1
        if prices[j] > prices[j + 1]:
            prices[j], prices[j + 1] = prices[j + 1], prices[j]
            names[j], names[j + 1] = names[j + 1], names[j]
            swaps += 1

print(f"   Steps: {steps}, Swaps: {swaps}")
for name, price in zip(names, prices):
    print(f"   P{price:>3} - {name}")

# Task 2: Python's built-in sorted()
print("\n-- Task 2: Python's sorted() (Timsort O(n log n)) --")
sorted_menu = sorted(menu, key=lambda x: x["price"])
for item in sorted_menu:
    print(f"   P{item['price']:>3} - {item['name']:15} {item['rating']}★")

# Task 3: Combo finder
print("\n-- Task 3: Best 2-Dish Combo Finder --")

def find_best_combo(menu, budget):
    best_combo = []
    best_rating = 0
    best_cost = 0
    pairs_checked = 0
    for i in range(len(menu)):
        for j in range(i + 1, len(menu)):
            pairs_checked += 1
            cost = menu[i]["price"] + menu[j]["price"]
            avg_rating = (menu[i]["rating"] + menu[j]["rating"]) / 2
            if cost <= budget and avg_rating > best_rating:
                best_combo = [menu[i], menu[j]]
                best_rating = avg_rating
                best_cost = cost
    return best_combo, best_cost, best_rating, pairs_checked

for budget in [80, 120, 160, 200]:
    combo, cost, rating, checked = find_best_combo(menu, budget)
    print(f"\n   Budget P{budget}:")
    if combo:
        for item in combo:
            print(f"     - {item['name']} (P{item['price']}, {item['rating']}★)")
        print(f"     Total: P{cost}, Avg rating: {rating:.2f}★, pairs checked: {checked}")
    else:
        print(f"     No combo fits.")

# Task 4: Linear Search
print("\n-- Task 4: Linear Search --")

def linear_search(menu, target_name):
    steps = 0
    for item in menu:
        steps += 1
        if item["name"].lower() == target_name.lower():
            return item, steps
    return None, steps

for target in ["Adobo", "Kare-Kare", "Lechon"]:
    item, steps = linear_search(menu, target)
    if item:
        print(f"   Found '{target}' after {steps} steps: P{item['price']}")
    else:
        print(f"   '{target}' not found after {steps} steps (entire menu scanned)")

# Task 5: Binary Search
print("\n-- Task 5: Binary Search (on sorted menu) --")

def binary_search(sorted_menu, target_name):
    target_low = target_name.lower()
    low, high = 0, len(sorted_menu) - 1
    steps = 0
    while low <= high:
        steps += 1
        mid = (low + high) // 2
        mid_name = sorted_menu[mid]["name"].lower()
        if mid_name == target_low:
            return sorted_menu[mid], steps
        elif mid_name < target_low:
            low = mid + 1
        else:
            high = mid - 1
    return None, steps

alphabetical = sorted(menu, key=lambda x: x["name"].lower())
for target in ["Adobo", "Kare-Kare", "Lechon"]:
    item, steps = binary_search(alphabetical, target)
    if item:
        print(f"   Found '{target}' after {steps} steps (binary)")
    else:
        print(f"   '{target}' not found after {steps} steps (binary)")

# Challenge: Triple combo
print("\n-- Challenge: Best 3-Dish Combo (budget P200) --")

def find_best_triple(menu, budget):
    best, best_avg, best_cost, triples = None, 0, 0, 0
    for i in range(len(menu)):
        for j in range(i + 1, len(menu)):
            for k in range(j + 1, len(menu)):
                triples += 1
                cost = menu[i]["price"] + menu[j]["price"] + menu[k]["price"]
                avg = (menu[i]["rating"] + menu[j]["rating"] + menu[k]["rating"]) / 3
                if cost <= budget and avg > best_avg:
                    best = [menu[i], menu[j], menu[k]]
                    best_avg = avg
                    best_cost = cost
    return best, best_cost, best_avg, triples

triple, cost, avg, triples = find_best_triple(menu, 200)
print(f"\n   Triples checked: {triples}")
if triple:
    for item in triple:
        print(f"   - {item['name']} (P{item['price']}, {item['rating']}★)")
    print(f"   Total: P{cost}, Avg rating: {avg:.2f}★")
