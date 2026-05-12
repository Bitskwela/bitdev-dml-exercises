# Luto AI â€” Carinderia Inventory Prototype

Build a simple demand-prediction tool for Tita Malou's carinderia. Use 30 days of generated data + day-of-week averages to forecast tomorrow's needs.

---

## Task 1: Generate Sample Data

The starter creates 30 days of sales with realistic patterns:
- Mon-Tue: low demand
- Fri-Sun: high demand
- Random noise to simulate real-world variability

---

## Task 2: Day-of-Week Analysis

Group sales by day of week, compute average demand per dish.

```python
by_day = df.groupby(["day_of_week", "dish"])["sold"].mean()
```

---

## Task 3: Demand Prediction

Use a weighted moving average:
- 70% last-4-week same-day average
- 30% overall average

```python
def predict_demand(dish, day_of_week, history):
    recent = [r for r in history[-28:] if r["day_of_week"] == day_of_week and r["dish"] == dish]
    if recent:
        return int(0.7 * mean(recent) + 0.3 * overall_mean)
    return overall_mean
```

---

## Task 4: Prep Recommendations

For tomorrow's weekday, predict demand for each dish. Add a 15% buffer.

```python
for dish in MENU:
    predicted = predict_demand(dish, tomorrow, history)
    recommended = int(predicted * 1.15)
    print(f"   {dish}: prep {recommended} servings (predicted {predicted})")
```

---

## Task 5: Low Stock Alerts

Define ingredient thresholds. If stock falls below, alert:

```python
stock = {"rice_kg": 5, "sinigang_mix": 2, "pork_kg": 0.5, "coconut_milk": 3}
thresholds = {"rice_kg": 10, "sinigang_mix": 3, "pork_kg": 2, "coconut_milk": 2}

for ingredient, qty in stock.items():
    if qty < thresholds[ingredient]:
        print(f"   ðŸš¨ {ingredient}: only {qty} left â€” ORDER NOW")
```

---

## Challenge A: PalengkeVision

Extend to track ingredient prices over time. Detect price spikes.

---

## Challenge B: Luto v2

Add:
- Weather factor (rainy â†’ more soup)
- Payday effect (+25% demand on 15th/30th)
- Trending detection (dish climbing in popularity)

---

## What You've Learned

- Simple time-series prediction (weighted moving average)
- Day-of-week demand patterns
- Threshold-based alerting
- Why simple models beat complex ones at hackathons

Next up: **Prompt Engineering** â€” Dan starts building the Luto chatbot.
