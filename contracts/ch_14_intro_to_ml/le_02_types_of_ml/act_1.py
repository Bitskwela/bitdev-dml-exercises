# ============================================
# ML PROBLEM TYPE CLASSIFIER — Lesson 2
# by: <Your Name>
# ============================================
# Sort carinderia problems into:
#   - Supervised regression
#   - Supervised classification
#   - Unsupervised
#   - Reinforcement
# Or:
#   - Unclear — needs more info
# ============================================


def classify_problem(description: str) -> str:
    """
    Read the problem description and return one of:
      'Supervised regression', 'Supervised classification',
      'Unsupervised', 'Reinforcement', or 'Unclear — needs more info'.
    """
    text = description.lower()

    # TODO: check reinforcement keywords FIRST (they sometimes contain "predict")
    # Hint: look for 'feedback', 'reward', 'reactions', 'trial and error'.

    # TODO: check regression keywords:
    # 'predict revenue', 'predict sales', 'predict quantity', 'forecast',
    # 'how many', 'how much', 'estimate the'

    # TODO: check classification keywords:
    # 'classify', 'is this', 'busy or slow', 'category', 'label each'

    # TODO: check unsupervised keywords:
    # 'group', 'segment', 'cluster', 'find similar', 'no labels'

    # TODO: fallback
    return "Unclear — needs more info"


# Eight problems to sort
problems = [
    "Predict tomorrow's total revenue at the carinderia.",
    "Group customers into similar buying types — no labels yet.",
    "Classify each sales day as busy, normal, or slow.",
    "Predict how many bowls of sinigang will sell on a rainy Friday.",
    "Make Luto learn which jokes get reactions from Tita Malou.",
    "Find similar items on the menu based on co-purchase patterns.",
    "Is this transaction fraud or not?",
    "Forecast next month's flour expense.",
    # TODO: add 2 more of your own
]

print("=" * 65)
print("  CARINDERIA ML PROBLEM SORTER")
print("=" * 65)
for i, p in enumerate(problems, 1):
    result = classify_problem(p)
    print(f"\n   [{i}] {p}")
    print(f"       -> {result}")
