# recommender_showdown.py
# ============================================
# RECOMMENDER SHOWDOWN — Full Solution
# by Dan Santos
# ============================================

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
print(f"  Total days of data: {len(sales_data)}")


def heuristic_recommender(weather, day, is_payday):
    """Tita Malou's 20 years of rules."""
    if is_payday:
        return "Kare-Kare"
    elif weather == "Rainy":
        return "Sinigang"
    elif weather == "Sunny":
        return "Halo-Halo"
    elif day == "Monday":
        return "Lugaw"
    else:
        return "Adobo"


def build_frequency_model(training_data):
    """Count best-seller frequency per (weather, day, is_payday) context."""
    model = {}
    for record in training_data:
        key = (record["weather"], record["day"], record["is_payday"])
        dish = record["best_seller"]
        if key not in model:
            model[key] = {}
        model[key][dish] = model[key].get(dish, 0) + 1
    return model


def data_recommender(model, weather, day, is_payday, fallback):
    """Recommend the most frequent best-seller for this context."""
    key = (weather, day, is_payday)
    if key in model:
        dishes = model[key]
        return max(dishes, key=dishes.get)
    return fallback


# Train/test split: 75% train, 25% test
random.shuffle(sales_data)
split = int(0.75 * len(sales_data))
train = sales_data[:split]
test = sales_data[split:]

# Build model on training data only
model = build_frequency_model(train)

# Overall mode as fallback
all_dishes = {}
for record in train:
    all_dishes[record["best_seller"]] = all_dishes.get(record["best_seller"], 0) + 1
fallback = max(all_dishes, key=all_dishes.get)

# Evaluate both on test set
heuristic_correct = 0
learning_correct = 0

print(f"\nTest set results (first 20):")
print(f"{'Context':<35} {'Actual':<15} {'Heur':<15} {'Data':<15}")
print("-" * 85)
for i, record in enumerate(test):
    w, d, p = record["weather"], record["day"], record["is_payday"]
    actual = record["best_seller"]
    heur = heuristic_recommender(w, d, p)
    data = data_recommender(model, w, d, p, fallback)

    if heur == actual:
        heuristic_correct += 1
    if data == actual:
        learning_correct += 1

    if i < 20:
        ctx = f"{w[:5]:5} {d[:3]:3} {'P' if p else '-':1}"
        h = "✓" if heur == actual else " "
        dd = "✓" if data == actual else " "
        print(f"   {ctx:<30} {actual:<15} {heur:<13} {h} {data:<13} {dd}")

print(f"\n" + "=" * 55)
print(f"  📊 SCOREBOARD")
print(f"=" * 55)
print(f"  Heuristic accuracy:    {heuristic_correct}/{len(test)} = {heuristic_correct/len(test)*100:.1f}%")
print(f"  Data-driven accuracy:  {learning_correct}/{len(test)} = {learning_correct/len(test)*100:.1f}%")
diff = (learning_correct - heuristic_correct) / len(test) * 100
print(f"  Learning edge:         {diff:+.1f}%")

print(f"\n  💡 Key insights:")
print(f"     - Heuristics: no data needed, deploy instantly")
print(f"     - Learning:   discovered patterns Mama missed")
print(f"     - In practice: start with heuristics, upgrade to learning")
