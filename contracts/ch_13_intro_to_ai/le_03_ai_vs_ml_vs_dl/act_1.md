# AI vs ML vs DL — Interactive Quiz

Now that you understand the three layers (AI → ML → DL), let's build a program that teaches the concept and then tests your knowledge with real-world scenarios.

---

## Task 1: Build the Quiz Program

Open `act_1.py`. The starter file has three functions to complete:

1. **`teach_concept()`** — Print the matryoshka doll explanation with the Filipino food analogy.
2. **`ask_question()`** — Already implemented for you. Study how it works.
3. **`show_results()`** — Display the final score with a message based on percentage.

Then add at least **5 quiz questions** in the main section using `ask_question()`.

### Suggested Questions

| Scenario | Correct Answer | Why |
|----------|---------------|-----|
| Thermostat that turns on AC at 30°C | AI (rule-based) | Simple IF-THEN rule, no learning |
| Shopee recommendations improving over time | ML | Learns from your shopping data |
| Self-driving car recognizing pedestrians | DL | Image recognition needs neural networks |
| Email filter with hardcoded spam keywords | AI (rule-based) | Preset list, no learning |
| GCash fraud detection from transaction patterns | ML | Learns patterns from data |

### Sample Output

```
🧠 QUIZ TIME! — 5 Questions

───────────────────────────────────────────────────────
  ❓ Question 1: A thermostat that turns on AC when temperature > 30°C
───────────────────────────────────────────────────────
     a) Machine Learning
     b) Deep Learning
     c) AI (rule-based)

     Your answer (a/b/c): c
     ✅ Correct! It follows a simple IF-THEN rule — no learning involved!

=======================================================
  📊 FINAL SCORE: 5/5
=======================================================
  🏆 PERFECT SCORE! You know this better than Jasper!
```

---

## Task 2: Reflect

After taking the quiz, answer these questions:

1. What makes something "Machine Learning" vs just "AI"?
2. Why does Deep Learning need more data and computing power than regular ML?
3. Can you think of a Filipino app that uses each type? (AI, ML, DL)

---

## Challenge: Expand the Quiz + Add Comparison Table

### Feature 1: Add 5 More Questions

Use these scenario ideas:
1. Waze rerouting based on real-time traffic from millions of drivers
2. A calculator app that adds numbers
3. Your phone's voice assistant understanding "Hey, what's the weather?"
4. Netflix learning your taste and recommending K-dramas
5. Dan's ulam recommender from Lesson 1

### Feature 2: Comparison Table Printer

Add a `print_comparison_table()` function that generates a clean comparison table the user can reference.

---

## What You've Learned

Through this activity, you have practiced:

- Building interactive quiz programs in Python
- Classifying real-world systems as AI, ML, or DL
- Understanding the nesting relationship (DL ⊂ ML ⊂ AI)
- Using the Filipino food analogy to remember the hierarchy

Next up: **How AI Works** — Dan discovers the AI pipeline at Tita Malou's carinderia.
