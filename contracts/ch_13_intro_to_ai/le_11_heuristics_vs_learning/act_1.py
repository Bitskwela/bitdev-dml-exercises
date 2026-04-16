# recommender_showdown.py
# ============================================
# RECOMMENDER SHOWDOWN
# by: <Your Name>
# ============================================
# Heuristic (rules) vs Learning (from data)

import random

random.seed(42)

# Generate 200 days of simulated sales data
sales_data = []
weathers = ["Sunny", "Rainy", "Cloudy"]
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

for _ in range(200):
    weather = random.choice(weathers)
    day = random.choice(days)
    is_payday = random.random() < 0.15

    # Patterns (learnable)
    if weather == "Rainy" and day == "Friday":
        best_seller = random.choices(
            ["Sinigang", "Adobo", "Lugaw"], weights=[45, 30, 25])[0]
    elif is_payday:
        best_seller = random.choices(
            ["Kare-Kare", "Bistek", "Adobo"], weights=[35, 20, 45])[0]
    elif day in ["Saturday", "Sunday"] and weather == "Sunny":
        best_seller = random.choices(
            ["Halo-Halo", "Adobo", "Bistek"], weights=[40, 30, 30])[0]
    elif day == "Monday":
        best_seller = random.choices(
            ["Lugaw", "Tortang Talong", "Adobo"], weights=[25, 18, 57])[0]
    else:
        best_seller = random.choices(
            ["Adobo", "Sinigang", "Bistek"], weights=[50, 25, 25])[0]

    sales_data.append({
        "weather": weather,
        "day": day,
        "is_payday": is_payday,
        "best_seller": best_seller
    })

print("=" * 55)
print("  RECOMMENDER SHOWDOWN: Heuristic vs Learning")
print("=" * 55)
print(f"  Sample data: {len(sales_data)} days")


# TODO: Task 2 — Heuristic recommender
# def heuristic_recommender(weather, day, is_payday):
#     Use if/elif to return a dish based on hand-coded rules


# TODO: Task 3 — Build frequency model from training data
# def build_frequency_model(training_data):
#     Build a dict keyed by (weather, day, is_payday)
#     Value is another dict counting how many times each dish was best_seller


# TODO: Task 4 — Data-driven recommender using the model
# def data_recommender(model, weather, day, is_payday):
#     Look up the key, return most common dish, with fallback to overall mode


# TODO: Task 5 — Train/test split, evaluate both, report accuracy
