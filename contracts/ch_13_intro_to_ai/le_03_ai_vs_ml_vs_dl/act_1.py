# ============================================
# AI vs ML vs DL — Interactive Quiz
# by: <Your Name>
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

    # TODO: Print the explanation of all three layers:
    #   - AI (biggest doll): any technique making machines smart
    #   - ML (fits inside AI): machines learn from data
    #   - DL (fits inside ML): neural networks with many layers
    #
    # Include the Filipino food analogy:
    #   PAGKAIN (Food) = AI
    #     └── LUTONG PINOY = ML
    #           └── SINIGANG = DL
    pass


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
    # TODO: Print score out of total
    # TODO: Calculate percentage and show a message:
    #   100% = Perfect score
    #   80%+ = Excellent
    #   60%+ = Nice work
    #   40%+ = Need review
    #   Below = Re-read the lesson
    # TODO: Print reminder about the nesting dolls
    pass


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

# TODO: Add at least 5 questions using ask_question()
# Example:
# ask_question(
#     "A thermostat that turns on AC when temperature > 30°C",
#     {"a": "Machine Learning", "b": "Deep Learning", "c": "AI (rule-based)"},
#     "c",
#     "It follows a simple IF-THEN rule — no learning involved!"
# )

# Step 3: Show results
show_results()
