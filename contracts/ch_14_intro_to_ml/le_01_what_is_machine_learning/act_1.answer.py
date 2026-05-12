# ============================================
# RULES vs EXAMPLES — Full Solution
# Lesson 1 by Dan Santos
# ============================================
# Two ways to encode the same carinderia logic:
#   1. Hand-written rules (the Luto v1 approach)
#   2. (features, label) examples (the ML approach)
# ============================================


# --- APPROACH 1: Hand-written rules ---

def recommend_ulam_rule_based(weather: str, is_payday: bool, day: str) -> str:
    """Luto v1's brain: a chain of if-elif rules."""
    if is_payday and weather == "sunny":
        return "Kare-Kare"
    if is_payday and weather == "rainy":
        return "Sinigang"
    if weather == "rainy":
        return "Sinigang"
    if day == "Friday":
        return "Kare-Kare"
    if day == "Sunday":
        return "Lechon Kawali"
    return "Adobo"


# --- APPROACH 2: Same logic, expressed as examples ---

examples = [
    # (weather,  is_payday, day_of_week, ulam_chosen)
    ("sunny",  True,  "Friday",    "Kare-Kare"),
    ("rainy",  True,  "Friday",    "Sinigang"),
    ("rainy",  False, "Tuesday",   "Sinigang"),
    ("sunny",  False, "Friday",    "Kare-Kare"),
    ("sunny",  False, "Sunday",    "Lechon Kawali"),
    ("cloudy", False, "Monday",    "Adobo"),
    ("rainy",  False, "Wednesday", "Sinigang"),
    ("sunny",  True,  "Saturday",  "Kare-Kare"),
]


# --- DEMO: rule-based brain ---

print("=" * 50)
print("  RULE-BASED LUTO (Approach 1)")
print("=" * 50)
test_days = [
    ("sunny",  True,  "Friday"),
    ("rainy",  False, "Tuesday"),
    ("cloudy", True,  "Monday"),
]
for w, p, d in test_days:
    ulam = recommend_ulam_rule_based(w, p, d)
    print(f"   {d:10} | {w:6} | payday={p}  ->  {ulam}")


# --- DEMO: example-based view ---

print()
print("=" * 50)
print("  EXAMPLE-BASED VIEW (Approach 2)")
print("=" * 50)
print(f"   Number of training examples: {len(examples)}")

unique_labels = sorted({row[3] for row in examples})
print(f"   Unique labels: {unique_labels}")
print(f"   Features per example: {len(examples[0]) - 1}  (weather, is_payday, day)")

print()
print("   First 3 training rows:")
for row in examples[:3]:
    w, p, d, y = row
    print(f"      features=(w={w!r}, payday={p}, day={d!r})  ->  label={y!r}")

print()
print("-- The shift --")
print("   In Approach 1, the rules live in YOUR HEAD.")
print("   In Approach 2, the rules live in the DATA.")
print("   ML is the practice of letting the computer extract")
print("   the rules from data — so you don't have to type them.")
