# ============================================
# AI vs ML vs DL — Interactive Quiz
# by Dan Santos
# ============================================
# Learn the differences, then test yourself!
# Uses the matryoshka doll / sinigang analogy.
# ============================================

score = 0
total = 0


def teach_concept():
    """Teach the core concepts before the quiz."""
    print("=" * 55)
    print("  AI vs ML vs DL — The Matryoshka Doll Analogy")
    print("=" * 55)

    print("""
    🤖 ARTIFICIAL INTELLIGENCE (AI)
       The biggest doll — ANY technique that makes
       machines act "smart"
       Example: A chess program with hardcoded rules
       Example: Dan's ulam recommender with if-else logic

    📊 MACHINE LEARNING (ML)
       Fits inside AI — machines that LEARN from data
       instead of following hardcoded rules
       Example: Spam filter that learns which emails are spam
       Example: Shopee recommendations based on your clicks

    🧠 DEEP LEARNING (DL)
       Fits inside ML — uses neural networks with
       many layers to learn complex patterns
       Example: Face recognition on your phone
       Example: ChatGPT understanding and generating text

    Think of it like Filipino food:
    🍲 PAGKAIN (Food)        = AI
       └── LUTONG PINOY      = Machine Learning
             └── SINIGANG    = Deep Learning

    All sinigang is lutong Pinoy, but not all lutong Pinoy
    is sinigang. All DL is ML, but not all ML is DL!
    """)


def ask_question(question, choices, correct, explanation):
    """Ask a quiz question and track the score."""
    global score, total
    total += 1

    print(f"\n{'─' * 55}")
    print(f"  ❓ Question {total}: {question}")
    print(f"{'─' * 55}")
    for letter, choice in choices.items():
        print(f"     {letter}) {choice}")

    answer = input("\n     Your answer (a/b/c): ").lower().strip()

    if answer == correct:
        score += 1
        print(f"     ✅ Correct! {explanation}")
    else:
        print(f"     ❌ Wrong — the correct answer is {correct})")
        print(f"     💡 {explanation}")


def show_results():
    """Display final quiz results."""
    print(f"\n{'=' * 55}")
    print(f"  📊 FINAL SCORE: {score}/{total}")
    print(f"{'=' * 55}")

    percentage = (score / total) * 100

    if score == total:
        print("  🏆 PERFECT SCORE! You know this better than Jasper!")
        print("  You totally understand AI vs ML vs DL!")
    elif percentage >= 80:
        print("  🌟 Excellent! Almost perfect — great job, Dan!")
    elif percentage >= 60:
        print("  👍 Nice work! But there's room for improvement.")
        print("  Review the concepts at the top and try again!")
    elif percentage >= 40:
        print("  📚 Not bad, but you need to review a bit more.")
        print("  Tip: Remember the nesting doll analogy!")
    else:
        print("  📖 Time to re-read the lesson, Dan!")
        print("  Remember: AI is the biggest doll, ML fits inside,")
        print("  and DL fits inside ML.")

    print(f"\n  💡 Remember the nesting dolls:")
    print(f"     AI (biggest) → ML (inside AI) → DL (inside ML)")


def print_comparison_table():
    """Print a detailed comparison table of AI vs ML vs DL."""
    print("\n" + "=" * 70)
    print("  📋 AI vs ML vs DL — COMPARISON TABLE")
    print("=" * 70)

    print(f"\n  {'─' * 64}")
    print(f"  | {'Feature':<14} | {'AI (Rule-Based)':<15} | {'Machine Learning':<16} | {'Deep Learning':<13} |")
    print(f"  {'─' * 64}")

    simple_rows = [
        ("Definition", "Rules from humans", "Learns from data", "Neural networks"),
        ("Rules by", "Human programmer", "Machine (data)", "Machine (layers)"),
        ("Data needed", "None/minimal", "Moderate", "Massive"),
        ("Computing", "Low", "Moderate", "Very high (GPU)"),
        ("Best for", "Simple tasks", "Patterns in data", "Images/speech/text"),
        ("PH Example", "Ulam recommender", "GCash fraud", "TikTok algorithm"),
        ("Food analogy", "Pagkain", "Lutong Pinoy", "Sinigang"),
    ]

    for feature, ai, ml, dl in simple_rows:
        print(f"  | {feature:<14} | {ai:<15} | {ml:<16} | {dl:<13} |")

    print(f"  {'─' * 64}")
    print(f"\n  💡 Remember: DL ⊂ ML ⊂ AI")
    print(f"     (Deep Learning is inside ML, which is inside AI)")


# ============================================
# MAIN PROGRAM
# ============================================

# Step 1: Teach the concepts
teach_concept()

input("Press Enter to start the quiz...\n")

# Step 2: Quiz!
print("🧠 QUIZ TIME! — 5 Questions")
print("Each question describes a real AI system.")
print("Your job: classify it as AI (rule-based), ML, or DL.\n")

ask_question(
    "A thermostat that turns on AC when temperature > 30°C",
    {
        "a": "Machine Learning",
        "b": "Deep Learning",
        "c": "AI (rule-based)"
    },
    "c",
    "It follows a simple IF-THEN rule written by a human — no learning involved!"
)

ask_question(
    "Shopee's product recommendations that improve the more you shop",
    {
        "a": "AI (rule-based)",
        "b": "Machine Learning",
        "c": "Not AI at all"
    },
    "b",
    "It LEARNS from your shopping data to improve recommendations — that's ML!"
)

ask_question(
    "A self-driving car that recognizes pedestrians using camera images",
    {
        "a": "AI (rule-based)",
        "b": "Machine Learning",
        "c": "Deep Learning"
    },
    "c",
    "Image recognition requires neural networks with many layers — that's Deep Learning!"
)

ask_question(
    "An email filter with a hardcoded list of spam keywords",
    {
        "a": "AI (rule-based)",
        "b": "Machine Learning",
        "c": "Deep Learning"
    },
    "a",
    "It uses a preset list written by a programmer — no learning, just rules. Basic AI!"
)

ask_question(
    "GCash detecting fraud by analyzing patterns in millions of transactions",
    {
        "a": "AI (rule-based)",
        "b": "Machine Learning",
        "c": "Not AI"
    },
    "b",
    "It learns fraud patterns from massive transaction data — classic ML!"
)

# Step 3: Show results
show_results()

# Bonus: Show comparison table
print_comparison_table()
