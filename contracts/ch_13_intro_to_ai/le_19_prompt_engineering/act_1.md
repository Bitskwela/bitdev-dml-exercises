# RCTFC Prompt Builder

Build a prompt-engineering toolkit: a builder, a quality scorer, and pre-made templates for Luto chatbot tasks.

---

## Task 1: Compare Weak vs Strong Prompts

The starter has 5 weak/strong pairs. Notice how strong prompts are 3x longer but vastly more useful.

---

## Task 2: RCTFC Builder

```python
def build_prompt(role, context, task, format_, constraints):
    return f"""Role: {role}
Context: {context}
Task: {task}
Format: {format_}
Constraints: {constraints}"""
```

---

## Task 3: Pre-Built Templates

Build templates for 4 Luto tasks:
- `menu_suggestion(weather, budget)` — suggest 5 dishes
- `customer_reply(question)` — polite Taglish-friendly response
- `cost_analysis(item, ingredients)` — break down costs
- `inventory_alert(ingredient, qty)` — urgency-appropriate notification

Each template returns a fully-formed RCTFC prompt.

---

## Task 4: Prompt Quality Scorer

```python
def score_prompt(prompt):
    score = 0
    if len(prompt) > 50: score += 1   # specificity
    if len(prompt.split()) > 20: score += 2
    if "format:" in prompt.lower(): score += 2
    if "context:" in prompt.lower(): score += 2
    if "constraint" in prompt.lower(): score += 2
    if "example" in prompt.lower() or "for instance" in prompt.lower(): score += 1
    return score
```

Test it on weak (~3) and strong (~9) prompts.

---

## Task 5: Improvement Suggestions

If a prompt scores low, point out which RCTFC element is missing.

---

## Challenge: Interactive Prompt Improver

Take a weak prompt as input. Output the improved RCTFC version + before/after scores.

---

## What You've Learned

- The RCTFC framework
- Reusable prompt templates
- Scoring prompt quality
- Why prompt engineering is a real skill

Next up: **APIs in AI** — Dan wires Luto to a real LLM.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the prompt builder, 4 Luto templates, scorer with explanations, and improvement engine.

</details>
