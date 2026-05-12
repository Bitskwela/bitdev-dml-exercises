# Build Luto: The chat() Function

Create the foundation of your chatbot â€” a single `chat()` function with personality, history tracking, and error handling.

---

## Task 1: Define LUTO_SYSTEM_PROMPT

Write a comprehensive system prompt covering:
- Identity (who is Luto)
- Personality (warm, practical, Taglish-friendly)
- Capabilities (menu planning, pricing, inventory, customer replies)
- Constraints (concise, PHP currency, don't over-promise)

---

## Task 2: Client Setup with Fallback

Reuse `MockOpenAI` from Lesson 21 or write a fresh one. Fall back to it if no API key is set.

---

## Task 3: Implement `chat()`

```python
history = [{"role": "system", "content": LUTO_SYSTEM_PROMPT}]

def chat(user_message):
    history.append({"role": "user", "content": user_message})
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=history,
        )
        reply = response.choices[0].message.content
        history.append({"role": "assistant", "content": reply})
        return reply
    except Exception as e:
        # Specific + generic handling
        return f"[Error] {e.__class__.__name__}: try again."
```

---

## Task 4: Scripted Test

Send 5 messages, print the exchange, then inspect the history.

```python
for msg in [
    "Kumusta?",
    "What should I cook for a rainy Friday?",
    "How much ingredients for 10 people?",
    "How long will it take to prep?",
    "Thank you!",
]:
    print(f"You: {msg}")
    print(f"Luto: {chat(msg)}\n")

print(f"History length: {len(history)} messages")
```

---

## Task 5: History Inspection

Print the first 3 and last 3 messages from history to confirm role progression (system â†’ user â†’ assistant â†’ user â†’ assistant ...).

---

## Challenge: Save/Load Conversation

```python
def save_conversation(filename):
    import json
    with open(filename, "w") as f:
        json.dump(history, f, indent=2)

def load_conversation(filename):
    global history
    import json
    with open(filename, "r") as f:
        history = json.load(f)
```

Save to `luto.json`. Reload it in a new session. Confirm context is preserved.

---

## What You've Learned

- Building chatbots in layers
- System prompt engineering for identity + constraints
- Conversation history management
- Error handling for real API failures
- Scripted tests before interactive UI
- Persistent conversation state via JSON

Next up: **Build an LLM Chatbot (Part 2)** â€” the chat loop.
