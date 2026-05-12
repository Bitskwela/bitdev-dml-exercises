# ============================================
# ML PROBLEM TYPE CLASSIFIER — Full Solution
# Lesson 2 by Dan Santos
# ============================================

def classify_problem(description: str) -> str:
    """
    Heuristic classifier. Reads a problem description and returns one of:
      'Supervised regression', 'Supervised classification',
      'Unsupervised', 'Reinforcement', or 'Unclear — needs more info'.
    """
    text = description.lower()

    # Reinforcement keywords first — they sometimes contain "predict"
    if any(k in text for k in ["feedback", "reward", "learn over time",
                                "reacts", "reactions", "trial and error"]):
        return "Reinforcement"

    # Regression keywords: predict a number
    regression_signals = [
        "predict revenue", "predict sales", "predict quantity",
        "predict price", "how many", "how much",
        "forecast", "estimate the",
    ]
    if any(k in text for k in regression_signals):
        return "Supervised regression"

    # Classification keywords
    classification_signals = [
        "classify", "is this", "spam or",
        "busy or slow", "category", "label each",
    ]
    if any(k in text for k in classification_signals):
        return "Supervised classification"

    # Clustering / unsupervised keywords
    clustering_signals = [
        "group", "segment", "cluster", "find similar",
        "no labels", "discover types",
    ]
    if any(k in text for k in clustering_signals):
        return "Unsupervised"

    return "Unclear — needs more info"


problems = [
    "Predict tomorrow's total revenue at the carinderia.",
    "Group customers into similar buying types — no labels yet.",
    "Classify each sales day as busy, normal, or slow.",
    "Predict how many bowls of sinigang will sell on a rainy Friday.",
    "Make Luto learn which jokes get reactions from Tita Malou.",
    "Find similar items on the menu based on co-purchase patterns.",
    "Is this transaction fraud or not?",
    "Forecast next month's flour expense.",
    "Detect days that look unusually different from neighbors.",
    "Suggest tomorrow's menu to maximize revenue based on Tita Malou's reactions over a week.",
]

print("=" * 65)
print("  CARINDERIA ML PROBLEM SORTER")
print("=" * 65)
for i, p in enumerate(problems, 1):
    result = classify_problem(p)
    print(f"\n   [{i}] {p}")
    print(f"       -> {result}")

print()
print("-- Reflection --")
print("   The classifier above is itself a rule-based system.")
print("   Notice how brittle it is: change a few words and it breaks.")
print("   In Lessons 4-15 we build classifiers that LEARN the keyword")
print("   weights from data instead of from these hand-typed checks.")
