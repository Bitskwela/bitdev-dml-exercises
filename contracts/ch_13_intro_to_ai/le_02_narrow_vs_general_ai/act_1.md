# The AI System Classifier

Now that you understand the three types of AI, let's build a program that classifies AI systems! You input the name of an AI system, and the program tells you what type it is and what it does.

---

## Task 1: Build the Basic Classifier

Open `act_1.py`. The starter file has `# TODO` markers. Your job is to:

1. **Build a dictionary** of at least 8 AI systems, each with `type`, `what_it_does`, and `philippine_context`.
2. **Create a lookup loop** that accepts user input and returns the system's classification.
3. **Handle unknown systems** with a helpful message (hint: if it exists today, it's Narrow AI!).

### How to Run

1. Open your terminal in the lesson folder.
2. Run: `python act_1.py`
3. Type AI system names when prompted.

### Sample Output

```
=======================================================
  AI SYSTEM CLASSIFIER
  Is it Narrow AI, General AI, or Super AI?
=======================================================

Available AI systems to classify:
   1. Grab
   2. Gcash Fraud Detection
   3. Shopee Recommendations
   ...

Enter an AI system to classify (or 'quit' to exit): grab

  ─────────────────────────────────────────────
  🤖 Grab
  Type: Narrow AI
  What it does: Optimizes routes and matches riders to drivers
  PH context: Used by millions of Filipinos daily for transportation
  Can it do OTHER things? ❌ Nope — it's specialized!
  ─────────────────────────────────────────────
```

---

## Task 2: Reflect

After classifying several systems, answer these questions:

1. Were any systems NOT Narrow AI? Why or why not?
2. Why is ChatGPT considered Narrow AI even though it seems to "know everything"?
3. What would General AI need to be able to do that current AI cannot?
4. Should we be scared of AI? Why or why not?

---

## Challenge: Add Quiz Mode

Upgrade the classifier with TWO new features:

### Feature 1: Add 5 More AI Systems

Add at least 5 more real-world AI systems. Ideas:
- Maya (formerly PayMaya) fraud detection
- Canva Magic Design
- Spotify Discover Weekly
- Tesla Autopilot
- Google Photos face grouping

### Feature 2: Quiz Mode

Add a quiz mode where the program describes an AI system and the user classifies it. Track the score!

### Challenge Sample Output

```
🧠 QUIZ MODE — 5 Questions
For each AI system, type: narrow, general, or super

  Question 1/5: Waze
  → Predicts traffic and suggests the fastest route
  Is this Narrow AI, General AI, or Super AI? narrow
  ✅ Correct! Waze is Narrow AI.

  ...

========================================
  Your Score: 4/5
========================================
  👍 Great job! Just a bit more review needed.
```

---

## What You've Learned

Through this activity, you have practiced:

- Building dictionary-based data structures in Python
- Creating interactive lookup programs
- Classifying real-world AI systems
- Understanding that ALL current AI is Narrow AI
- Building quiz functionality with score tracking

Next up: **AI vs ML vs DL** — Dan learns the difference between AI, Machine Learning, and Deep Learning.

---

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Basic Classifier

```python
ai_systems = {
    "grab": {
        "type": "Narrow AI",
        "what_it_does": "Optimizes routes and matches riders to drivers",
        "philippine_context": "Used by millions of Filipinos daily for transportation"
    },
    "gcash fraud detection": {
        "type": "Narrow AI",
        "what_it_does": "Detects suspicious transactions to prevent scams",
        "philippine_context": "Protects over 80 million GCash users in the Philippines"
    },
    # ... (see act_1.answer.py for the full dictionary)
}

while True:
    user_input = input("Enter an AI system (or 'quit'): ").lower().strip()
    if user_input == "quit":
        break
    if user_input in ai_systems:
        system = ai_systems[user_input]
        print(f"  Type: {system['type']}")
        print(f"  What it does: {system['what_it_does']}")
    else:
        print("  Not in database. But if it exists today → Narrow AI!")
```

### Task 2: Reflection Answers

1. **No systems were General or Super AI** — because those types don't exist yet.
2. **ChatGPT is Narrow AI** because it only generates text. It can't drive, see images (without plugins), or perform surgery. It's very good at ONE thing: text generation.
3. **General AI would need** to learn any new task without specific training, transfer knowledge across domains, have common sense reasoning, and understand context/emotion like humans.
4. **No need to fear AI** — focus on learning to build it. Narrow AI is a tool, not a threat.

### Challenge: Quiz Mode

See `act_1.answer.py` for the complete v2.0 with quiz mode and 17 AI systems.

</details>
