# ============================================
# RULES vs EXAMPLES — Lesson 1
# by: <Your Name>
# ============================================
# Two ways to encode the same carinderia logic.
# Approach 1 = if-elif rules (the Luto v1 way).
# Approach 2 = (features, label) examples (the ML way).
# ============================================


# ===== APPROACH 1: Hand-written rules =====

def recommend_ulam_rule_based(weather: str, is_payday: bool, day: str) -> str:
    """
    Return the ulam to recommend for the given conditions.

    Suggested rules:
      payday + sunny       -> "Kare-Kare"
      payday + rainy       -> "Sinigang"
      rainy (otherwise)    -> "Sinigang"
      day == "Friday"      -> "Kare-Kare"
      day == "Sunday"      -> "Lechon Kawali"
      (anything else)      -> "Adobo"
    """
    # TODO: implement the if-elif chain above and return the correct string.
    pass


# ===== APPROACH 2: Same logic, as examples =====
# Each row: (weather, is_payday, day_of_week, ulam_chosen)
# Add at least 6 example rows. The first three are filled in for you.

examples = [
    ("sunny",  True,  "Friday",   "Kare-Kare"),
    ("rainy",  True,  "Friday",   "Sinigang"),
    ("rainy",  False, "Tuesday",  "Sinigang"),
    # TODO: add at least 3 more rows below
]


# ===== DEMO =====

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

# TODO: After you fill in `examples`, print the unique labels found in it.
# Hint: use a set comprehension on the last item of each tuple.
print()
print("=" * 50)
print("  EXAMPLE-BASED VIEW (Approach 2)")
print("=" * 50)
print(f"   Number of training examples: {len(examples)}")
# TODO: print unique labels (sorted)
# TODO: print number of features per example (each tuple length minus 1)
