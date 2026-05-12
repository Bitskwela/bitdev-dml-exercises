# First OpenAI Call (with Mock Fallback)

Make your first real call to an LLM — or run in mock mode if you don't have an API key.

---

## Prerequisites (Optional)

```
pip install openai python-dotenv
```

If you have an API key, set it in a `.env` file:
```
OPENAI_API_KEY=sk-...
```

If you don't, the code falls back to a `MockOpenAI` that simulates responses — so the exercise works offline.

---

## Task 1: Client Setup with Fallback

```python
try:
    from openai import OpenAI
    import os
    if os.environ.get("OPENAI_API_KEY"):
        client = OpenAI()
        MOCK_MODE = False
    else:
        client = MockOpenAI()
        MOCK_MODE = True
except ImportError:
    client = MockOpenAI()
    MOCK_MODE = True
```

---

## Task 2: First Call

System prompt: "You are Luto, a friendly Filipino carinderia assistant."
User prompt: "What should I cook for a rainy Friday?"

Print the response.

---

## Task 3: Temperature Experiments

Same prompt, different temperatures (0.0, 0.7, 1.2). Observe how the creativity changes.

---

## Task 4: Multi-Turn Conversation

Build a list of messages that grows:

```python
history = [
    {"role": "system", "content": "..."},
]

def ask(user_msg):
    history.append({"role": "user", "content": user_msg})
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=history,
    )
    reply = response.choices[0].message.content
    history.append({"role": "assistant", "content": reply})
    return reply

ask("What should I cook?")
ask("How much for 10 people?")   # references previous answer
ask("How long will it take?")    # still remembers context
```

---

## Task 5: Token Budget Tracker

Track total tokens used across all calls. Stop if you exceed P500 worth of tokens (~500K tokens at gpt-3.5-turbo).

---

## Challenge: ask_luto_multi

Build specialized helpers:
- `ask_menu_planner(weather, budget)` — uses a menu-planner system prompt
- `ask_pricing(item, ingredients)` — uses a pricing system prompt
- `ask_inventory(stock)` — uses an inventory system prompt
- `ask_general(question)` — falls back to default system prompt

Each switches the system prompt for a different "mode."

---

## What You've Learned

- OpenAI SDK: `client.chat.completions.create(...)`
- Message roles (system, user, assistant)
- Temperature's effect on creativity
- Multi-turn conversations via growing `messages` list
- Mock clients for offline development
- Token tracking for cost management

Next up: **Build an LLM Chatbot (Part 1)** — foundation of Luto.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for a complete setup with `MockOpenAI`, real/mock fallback, temperature experiments, multi-turn demo, and token budget tracker.

</details>
