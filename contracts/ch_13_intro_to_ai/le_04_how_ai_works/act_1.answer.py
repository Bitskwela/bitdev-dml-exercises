# ============================================
# CARINDERIA SALES PREDICTOR v2.0
# by Dan Santos
# ============================================
# Enhanced version with batch scenarios.
# Demonstrates the Data -> Model -> Output pipeline.
# ============================================

print("=" * 60)
print("  CARINDERIA SALES PREDICTOR v2.0")
print("  Now with batch scenarios and more factors!")
print("=" * 60)

# Define 5 test scenarios as dictionaries
scenarios = [
    {
        "name": "Rainy Payday Friday",
        "weather": "rainy",
        "is_payday": True,
        "day": "friday",
        "has_event": False,
        "temperature": 28,
        "is_holiday": False,
        "school_nearby": True,
    },
    {
        "name": "Fiesta Weekend",
        "weather": "sunny",
        "is_payday": False,
        "day": "saturday",
        "has_event": True,
        "temperature": 34,
        "is_holiday": False,
        "school_nearby": False,
    },
    {
        "name": "Quiet Monday",
        "weather": "cloudy",
        "is_payday": False,
        "day": "monday",
        "has_event": False,
        "temperature": 30,
        "is_holiday": False,
        "school_nearby": True,
    },
    {
        "name": "Holiday + Payday Combo",
        "weather": "sunny",
        "is_payday": True,
        "day": "friday",
        "has_event": False,
        "temperature": 32,
        "is_holiday": True,
        "school_nearby": False,
    },
    {
        "name": "Hot Tuesday",
        "weather": "sunny",
        "is_payday": False,
        "day": "tuesday",
        "has_event": False,
        "temperature": 35,
        "is_holiday": False,
        "school_nearby": True,
    },
]


def predict_sales(scenario):
    """
    The MODEL function.
    Takes a scenario (data) and returns a prediction (output).
    This IS the AI pipeline in one function!
    """
    score = 0

    # Payday rule
    if scenario["is_payday"]:
        score += 3

    # Weekend rule
    if scenario["day"] in ["saturday", "sunday"]:
        score += 2
    elif scenario["day"] == "friday":
        score += 1

    # Weather rule
    if scenario["weather"] in ["rainy", "sunny"]:
        score += 1

    # Event rule
    if scenario["has_event"]:
        score += 3

    # Holiday rule — big boost
    if scenario["is_holiday"]:
        score += 3

    # School nearby in session
    if scenario["school_nearby"]:
        score += 1

    # Very hot temperature reduces foot traffic
    if scenario["temperature"] > 33:
        score -= 1

    # Convert score to prediction
    if score >= 7:
        return score, "VERY HIGH"
    elif score >= 4:
        return score, "HIGH"
    elif score >= 2:
        return score, "NORMAL"
    else:
        return score, "LOW"


# Run predictions on all scenarios
print(f"\n{'Scenario':<25} {'Score':>5} {'Prediction':<12}")
print("-" * 45)

max_score = -999
max_name = ""
min_score = 999
min_name = ""

for scenario in scenarios:
    score, prediction = predict_sales(scenario)
    print(f"{scenario['name']:<25} {score:>5} {prediction:<12}")
    if score > max_score:
        max_score = score
        max_name = scenario["name"]
    if score < min_score:
        min_score = score
        min_name = scenario["name"]

print("-" * 45)
print(f"\n🔥 Highest predicted sales: {max_name} (score {max_score})")
print(f"📉 Lowest predicted sales:  {min_name} (score {min_score})")

print("\n" + "=" * 60)
print("  THE AI PIPELINE IN ACTION:")
print("  DATA (8 factors) -> MODEL (scoring rules) -> OUTPUT (prediction)")
print("=" * 60)
