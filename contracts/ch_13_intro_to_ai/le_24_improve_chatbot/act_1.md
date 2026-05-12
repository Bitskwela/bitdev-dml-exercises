# Polish Luto: v3.0

Improve Luto based on real user feedback. Add memory management, better prompts, and two specialized commands.

---

## Task 1: Enhanced System Prompt

Inject a MENU_DATABASE into the prompt so Luto knows actual dishes + prices:

```python
MENU_DATABASE = {
    "Adobo":    {"cost": 35, "price": 60, "best_days": ["Mon-Fri"]},
    "Sinigang": {"cost": 38, "price": 65, "best_days": ["rainy"]},
    "Bistek":   {"cost": 42, "price": 70, "best_days": ["Fri-Sat"]},
    ...
}

# Format it into the system prompt as text.
```

---

## Task 2: Memory Management

```python
MAX_HISTORY_PAIRS = 8

def trim_history():
    global history
    if len(history) > 1 + MAX_HISTORY_PAIRS * 2:
        history = [history[0]] + history[-(MAX_HISTORY_PAIRS * 2):]
```

Call after every `chat()`.

---

## Task 3: /suggest Command

Given a day + weather, recommend 3 dishes with projections (expected quantity, expected revenue).

```python
def suggest_command(day, weather):
    # Consult MENU_DATABASE, return top 3 with projected numbers
    ...
```

---

## Task 4: /cost Command

Given a dish name, print ingredient cost, suggested price, and profit margin.

```python
def cost_command(dish):
    data = MENU_DATABASE.get(dish)
    if not data:
        print(f"  {dish} not in database")
        return
    profit = data["price"] - data["cost"]
    margin = profit / data["cost"] * 100
    print(f"  {dish}: cost P{data['cost']}, price P{data['price']}, "
          f"profit P{profit} ({margin:.0f}% margin)")
```

---

## Task 5: Better Error Messages

```python
def handle_api_error(e):
    error_type = e.__class__.__name__
    if "Auth" in error_type:
        return "Authentication failed. Check .env for valid OPENAI_API_KEY."
    if "RateLimit" in error_type:
        return "Rate limited. Wait 20 seconds and try again."
    if "Connection" in error_type or "Timeout" in error_type:
        return "Connection issue. Check your internet, then retry."
    return f"Unexpected: {error_type}: {e}"
```

---

## Challenge: /summary Command

Analyze the conversation history and summarize the topics discussed. Group by category:
- Menu questions
- Pricing questions
- Inventory questions
- Customer reply help
- Other

---

## What You've Learned

- Iteration based on user feedback
- Memory management to control token usage
- Grounding LLM answers in real data (MENU_DATABASE)
- Specialized commands for routine tasks
- Error messages that tell users HOW to fix problems

Next up: **Deploy AI App** â€” Streamlit + the hackathon.
