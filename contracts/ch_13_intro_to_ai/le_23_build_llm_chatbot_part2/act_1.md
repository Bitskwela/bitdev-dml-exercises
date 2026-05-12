# Make Luto Interactive

Wrap your `chat()` function in a loop with slash commands. Fix the stateless bug and deliver a fully interactive chatbot.

---

## Task 1: The Chat Loop

```python
while True:
    user_input = input("You: ").strip()
    if not user_input:
        continue
    if user_input.startswith("/"):
        handle_command(user_input)
        continue
    reply = chat(user_input)
    print(f"Luto: {reply}\n")
```

---

## Task 2: Slash Commands

Implement:
- `/help` — list commands
- `/history` — print conversation history (role, first 60 chars)
- `/tokens` — total tokens + estimated P cost
- `/clear` — reset history (keep only system prompt)
- `/quit` or `/bye` — exit with session summary

---

## Task 3: Session Stats

Track:
- Message count
- Total tokens
- Session start time

Show on `/quit`.

---

## Task 4: Scripted Demo

Since `input()` is interactive, provide a scripted test mode too:

```python
def scripted_test():
    for msg in [
        "Kumusta po!",
        "What's good for rainy Friday dinner?",
        "How much ingredients for 10 people?",
        "How long to prep?",
        "/history",
        "/tokens",
        "Thank you!",
        "/bye",
    ]:
        ...
```

---

## Challenge: Save/Load Commands

Add `/save luto.json` and `/load luto.json`. Lets you resume conversations across sessions.

---

## What You've Learned

- Wrapping chat() in an interactive while loop
- Handling slash commands separately from messages
- Scope bug: history must live OUTSIDE the loop
- Session state tracking
- Scripted test mode for non-interactive runs

Next up: **Improve Chatbot** — polish Luto with real user feedback.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the complete interactive Luto with all slash commands, session tracking, and scripted test mode.

</details>
