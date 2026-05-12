# The Ulam Recommender — Your First "AI"

Now that you understand what AI is, let's build your first "AI" program. This Python script acts as a smart ulam (dish) recommendation system. It asks the user about their situation and recommends a Filipino dish based on simple if-else logic.

This is exactly how early AI systems worked — experts wrote rules by hand. It is called a **rule-based system** or **expert system**.

---

## Task 1: Build the Basic Recommender

Open `act_1.py`. The starter file has `# TODO` markers. Your job is to:

1. **Gather three inputs** from the user: weather, budget, and mood.
2. **Use if-elif-else** to recommend a Filipino dish based on those inputs.
3. **Print the recommendation** along with a short explanation of the INPUT → PROCESS → OUTPUT pattern.

### Suggested Logic

| If... | Then recommend... |
|-------|-------------------|
| `weather == "hot"` and `budget == "high"` | Halo-Halo + Kare-Kare |
| `weather == "rainy"` and `mood == "stressed"` | Sinigang na Baboy |
| `weather == "rainy"` (otherwise) | Tinola |
| `weather == "cold"` | Bulalo |
| `budget == "low"` | Tortang Talong + Rice |
| `mood == "happy"` | Crispy Pata |
| `mood == "tired"` | Arroz Caldo |
| *(anything else)* | Adobo — the classic! |

### How to Run

1. Open your terminal in the lesson folder.
2. Run: `python act_1.py`
3. Answer the prompts when they appear.

### Sample Output

```
========================================
  ULAM RECOMMENDER by Dan Santos
========================================

How's the weather? (hot/rainy/cold): rainy
What's your budget? (high/medium/low): medium
What's your mood? (happy/tired/stressed): stressed

🍽️ Recommended Ulam for you:
➡️ Sinigang na Baboy — comfort food for a rainy day!

💡 This is how AI works at a basic level:
   INPUT (data) → PROCESS (rules) → OUTPUT (decision)
   Real AI learns these rules from data instead of us writing them!
```

---

## Task 2: Understand the Code

After running your program, think about what just happened:

1. **Data Collection** — You gathered three inputs from the user. In real AI systems, data comes from sensors, databases, user behavior, etc.

2. **Decision Logic** — The `if-elif-else` chain is your "brain." It takes the inputs and applies rules to reach a conclusion. This is called a **decision tree** — one of the simplest forms of AI logic.

3. **Output** — The recommendation is the system's "intelligent" response. It feels smart because it considers multiple factors, just like a human would.

4. **The Limitation** — You had to write every single rule by hand. What if there are 100 factors? 1,000 dishes? That is where Machine Learning comes in (Lesson 3).

### Reflection Questions

1. Why does this program *feel* intelligent even though it is just if-else?
2. What would happen if you had to add 50 more dishes and 10 more inputs?
3. Where do the "rules" in your program come from?
4. How is this different from what Grab or Netflix do?

---

## Challenge: Level Up the Ulam Recommender

Expand the recommender by adding **3 more conditions** to make it smarter. Here are some ideas:

1. **Number of people eating** — Solo meal vs. family-style vs. barkada feast
2. **Time of day** — Breakfast, lunch, merienda, or dinner
3. **Special occasion** — Birthday, payday, regular day, exam week

### Challenge Sample Output

```
=============================================
  ULAM RECOMMENDER v2.0 by Dan Santos
=============================================

How's the weather? (hot/rainy/cold): hot
What's your budget? (high/medium/low): low
What's your mood? (happy/tired/stressed): happy
How many are eating? (solo/family/barkada): barkada
What time is it? (morning/noon/merienda/evening): evening
Any occasion? (birthday/payday/regular/exam-week): regular

🍽️ Recommended Ulam for you:
➡️ Street BBQ — isaw, betamax — barkada bonding!

💡 Notice how more inputs = smarter recommendations?
   Real AI systems consider THOUSANDS of factors!
   That's why they need Machine Learning — too many rules to write by hand.
```

### Bonus Challenge

Run your enhanced recommender with different input combinations. Notice how the more inputs you add, the more branches your code needs. Imagine what it would look like with 100 inputs and 1,000 dishes. This is exactly why we need Machine Learning — there is a limit to how many rules a human can write by hand.

---

## What You've Learned

Through this activity, you have practiced:

- Gathering input from users in Python
- Using `if-elif-else` chains for decision logic
- Building a simple rule-based expert system
- Understanding the INPUT → PROCESS → OUTPUT pattern that underlies all AI
- Seeing the limitations of hand-coded rules (which motivates Machine Learning)

Next up: **Narrow vs General AI** — Kuya JM helps Dan separate AI hype from reality.

---

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Basic Recommender

```python
# ============================================
# ULAM RECOMMENDER - Your First "AI"
# by Dan Santos
# ============================================

print("=" * 40)
print("  ULAM RECOMMENDER by Dan Santos")
print("=" * 40)

# Step 1: Gather inputs (data collection)
weather = input("\nHow's the weather? (hot/rainy/cold): ").lower()
budget = input("What's your budget? (high/medium/low): ").lower()
mood = input("What's your mood? (happy/tired/stressed): ").lower()

# Step 2: Process the data using rules (decision logic)
print("\n🍽️ Recommended Ulam for you:")

if weather == "hot" and budget == "high":
    print("➡️ Halo-Halo + Kare-Kare — cool down and treat yourself!")
elif weather == "rainy":
    if mood == "stressed":
        print("➡️ Sinigang na Baboy — comfort food for a rainy day!")
    else:
        print("➡️ Tinola — warm and nutritious!")
elif weather == "cold":
    print("➡️ Bulalo — perfect for cold weather!")
elif budget == "low":
    print("➡️ Tortang Talong + Rice — delicious and budget-friendly!")
elif mood == "happy":
    print("➡️ Crispy Pata — celebration food!")
elif mood == "tired":
    print("➡️ Arroz Caldo — warm and comforting!")
else:
    print("➡️ Adobo — the classic! You can never go wrong.")

# Step 3: Explain the AI connection
print("\n💡 This is how AI works at a basic level:")
print("   INPUT (data) → PROCESS (rules) → OUTPUT (decision)")
print("   Real AI learns these rules from data instead of us writing them!")
```

### Challenge: Enhanced Recommender

See `act_1.answer.py` for the full v2.0 solution with 6 inputs and time/occasion/group-size-based recommendations.

### Reflection Answers

1. **Why does it feel intelligent?** Because it considers multiple factors and reaches a tailored conclusion — just like a human would.
2. **50 more dishes + 10 more inputs?** The if-elif chain becomes enormous and unmaintainable. This is why Machine Learning exists.
3. **Where do the rules come from?** From *you* — the programmer. In ML, rules come from patterns in data.
4. **How is this different from Grab/Netflix?** Those systems *learned* their rules from millions of user interactions. Our recommender has hand-coded rules and cannot improve on its own.

</details>
