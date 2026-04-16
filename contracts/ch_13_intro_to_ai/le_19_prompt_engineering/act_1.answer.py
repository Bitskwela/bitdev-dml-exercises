# prompt_engineering.py
# ============================================
# PROMPT ENGINEERING TOOLKIT — Full Solution
# by Dan Santos
# ============================================

print("=" * 55)
print("  PROMPT ENGINEERING TOOLKIT")
print("=" * 55)


def build_prompt(role, context, task, format_, constraints):
    return (
        f"Role: {role}\n"
        f"Context: {context}\n"
        f"Task: {task}\n"
        f"Format: {format_}\n"
        f"Constraints: {constraints}"
    )


# Templates for Luto
def menu_suggestion_prompt(weather, budget):
    return build_prompt(
        role="Experienced carinderia owner in Marikina with 15 years of experience",
        context=f"A customer needs a meal recommendation. Weather is {weather}, budget is P{budget}.",
        task="Suggest 5 Filipino dishes that fit the weather and budget, ordered by appeal.",
        format_="Markdown table: | Dish | Why it fits | Est. price |",
        constraints="Filipino dishes only. Each dish must fit within the budget.",
    )


def customer_reply_prompt(question):
    return build_prompt(
        role="Warm, polite carinderia assistant named Luto",
        context=f"A customer asked: \"{question}\"",
        task="Respond helpfully in 2-3 sentences. Match the customer's language (English or Taglish).",
        format_="Plain text, friendly tone.",
        constraints="Never promise something not on the menu. Stay warm but concise.",
    )


def cost_analysis_prompt(item, ingredients):
    return build_prompt(
        role="Restaurant business consultant specializing in Philippine food operations",
        context=f"Analyzing '{item}' with ingredients: {ingredients}",
        task="Calculate ingredient cost, suggest a selling price, and compute profit margin.",
        format_="Bullet list: Cost, Suggested price (with 60-80% markup), Profit per serving, Note.",
        constraints="Use PHP. Assume Metro Manila palengke prices as of 2026. Keep numbers realistic.",
    )


def inventory_alert_prompt(ingredient, qty):
    return build_prompt(
        role="Inventory manager for a small carinderia",
        context=f"Current stock of '{ingredient}' is {qty}. This is below safe threshold.",
        task="Write a 1-sentence alert suitable for a phone notification.",
        format_="Plain text, urgent but not panicky tone.",
        constraints="Max 15 words. Include the ingredient name and recommended action.",
    )


# Quality scorer
def score_prompt(prompt):
    score = 0
    notes = []
    p = prompt.lower()

    if len(prompt) > 80:
        score += 1
        notes.append("✓ Reasonable length (specificity)")
    else:
        notes.append("✗ Too short — add more context")

    if len(prompt.split()) > 25:
        score += 2

    if "role:" in p or "as a" in p or "you are" in p:
        score += 1
        notes.append("✓ Role defined")
    else:
        notes.append("✗ No ROLE — tell the AI who it should be")

    if "context:" in p or "situation" in p or "background" in p:
        score += 1
        notes.append("✓ Context provided")
    else:
        notes.append("✗ No CONTEXT — describe the situation")

    if "format:" in p or "table" in p or "list" in p or "json" in p or "bullet" in p:
        score += 2
        notes.append("✓ Format specified")
    else:
        notes.append("✗ No FORMAT — say how the response should look")

    if "constraint" in p or "must" in p or "only" in p or "no more than" in p:
        score += 2
        notes.append("✓ Constraints set")
    else:
        notes.append("✗ No CONSTRAINTS — set limits or rules")

    if "example" in p or "for instance" in p:
        score += 1
        notes.append("✓ Example included")

    return score, notes


# Task 1: Demo comparisons
comparisons = [
    ("help me with python",
     build_prompt("Python tutor", "Student learning list comprehensions",
                  "Explain with 3 examples using Filipino food data",
                  "Code snippets with comments", "Max 200 words, beginner-friendly")),
    ("recommend dishes", menu_suggestion_prompt("rainy", 80)),
    ("inventory alert example", inventory_alert_prompt("coconut milk", 2)),
]

for weak, strong in comparisons:
    print("\n" + "─" * 55)
    print(f"  WEAK:   \"{weak}\"")
    w_score, _ = score_prompt(weak)
    print(f"  Score: {w_score}/10")
    print(f"\n  STRONG:\n{strong}")
    s_score, notes = score_prompt(strong)
    print(f"\n  Score: {s_score}/10")
    for note in notes:
        print(f"     {note}")

# Usage examples for Luto
print("\n" + "=" * 55)
print("  READY-TO-USE LUTO TEMPLATES")
print("=" * 55)
print("\n-- Menu suggestion (rainy, P80 budget) --")
print(menu_suggestion_prompt("rainy", 80))
print("\n-- Customer reply --")
print(customer_reply_prompt("Ate, may sinigang pa ba kayo?"))
print("\n-- Cost analysis --")
print(cost_analysis_prompt("Sinigang na Baboy", "pork belly, sinigang mix, tomato, kangkong, gabi"))
print("\n-- Inventory alert --")
print(inventory_alert_prompt("rice", 1.5))
