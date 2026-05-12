## Previously on Dan's AI Journey...

Dan built the foundation of Luto — a `chat()` function with personality, history, and error handling.

---

## Background Story

11 PM. Dan's dorm. He stared at the working `chat()` function. It worked. It responded. But it wasn't a chatbot yet — it was a function.

He typed `while True:` and kept going. First test:

```
You: What should I cook tonight? It's rainy.
Luto: Sinigang na Baboy — comfort food for rainy weather!
You: How much for 10 people?
Luto: Based on standard sinigang recipe, for 10 people... [generic answer]
```

Wait. Luto didn't remember they were talking about sinigang. Why?

Dan messaged Kuya JM, panicked.

> **Dan:** *"Kuya, the chatbot forgot! It answered the second question like it was a fresh conversation."*
>
> **Kuya JM:** *"Show me your code."*
>
> *[Dan pastes]*
>
> **Kuya JM:** *"See this line? `history = [...]` — you're RESETTING history inside your loop. Every iteration creates a new conversation. Move that list OUTSIDE the loop. The whole point of the history is that it grows."*

Dan moved the list outside. Tested again. Luto remembered. The conversation flowed. Dan added slash commands: `/help`, `/history`, `/tokens`, `/clear`, `/quit`. He added token tracking. At 2 AM he had a complete, interactive chatbot.

He sat back. "Luto exists."

---

## Theory & Lecture Content

### The Chat Loop Pattern

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

### Common Slash Commands

| Command | Purpose |
|---------|---------|
| `/help` | Show available commands |
| `/history` | Display conversation so far |
| `/tokens` | Show token usage + estimated cost |
| `/clear` | Reset conversation (keep system prompt) |
| `/save filename` | Persist conversation to JSON |
| `/load filename` | Restore saved conversation |
| `/quit` or `/bye` | Exit cleanly |

### Scope: Putting History in the Right Place

```python
# BAD — resets each iteration
while True:
    history = [{"role": "system", "content": SYSTEM}]   # DON'T do this
    user = input()
    ...

# GOOD — history grows across the loop
history = [{"role": "system", "content": SYSTEM}]
while True:
    user = input()
    ...
```

This is a subtle but critical bug. Dan hit it. You might hit it too.

### Session State

Track useful session info:
- Number of messages
- Total tokens used
- Start time (duration)
- Slash commands issued

Show it on `/quit`:

```
Session summary:
  Messages:   14
  Tokens:     2847
  Duration:   0:08:23
  Commands:   3
```

### Token Cost Growth

Because you send the full history each time, conversations get more expensive as they grow.

- Message 1: ~100 tokens
- Message 10: ~1000 tokens (previous 9 + current)
- Message 50: ~5000 tokens

To manage: trim old messages (next lesson).

---

## Key Takeaways

1. **A while loop turns `chat()` into an interactive chatbot.**
2. **Slash commands** add utility without cluttering the main conversation.
3. **History list MUST be outside the loop** — or you lose context.
4. **Track session state** for debugging and user feedback.
5. **Token cost grows with conversation length** — every turn sends the full history.
6. **Test the full flow** — scripted tests + interactive testing before adding UI.

---

## What's Next?

Luto works. But when Dan tested with Tita Malou, some answers were too generic. Time to improve.

**Next Lesson: Improve Chatbot** — better system prompt, memory management, specialized commands.

**Next:** Quiz then exercises.
