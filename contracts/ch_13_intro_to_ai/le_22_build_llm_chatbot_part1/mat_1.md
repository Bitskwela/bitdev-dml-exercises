## Previously on Dan's AI Journey...

Dan made his first real OpenAI API call, experimented with temperature, and built a mock client for offline development.

---

## Background Story

9 PM. University computer lab. Dan opened a new file: `chatbot.py`. His cursor blinked on line 1.

He typed:

```python
# chatbot.py
# by Dan Santos
# Luto — AI assistant for small carinderias
```

His hands shook — not from caffeine (he'd given that up a week ago), but from the weight of the moment. This was it. Everything converging. Every lesson he'd taken, every concept he'd learned, every late-night struggle — all leading to *this file.*

Kuya JM's words echoed: *"Walk before you run. One function. One test. That's your goal for tonight."*

By 11 PM, Dan had a working `chat()` function. Error handling for Auth/RateLimit/Connection. Luto personality defined in a system prompt. A test that sent 5 messages and verified context preservation. The conversation history list grew from 2 items to 12 as the chat progressed.

He leaned back and stared at his screen for a long time. The chatbot wasn't fancy. No web UI. No fancy features. Just a function that took a string and returned a string. But it *worked*, and it felt like his.

---

## Theory & Lecture Content

### Separation of Concerns

Good chatbot code has clean layers:

1. **Setup** — client creation, API key handling
2. **Personality** — system prompt defining who Luto is
3. **Logic** — the `chat()` function that sends/receives
4. **Testing** — scripted messages to verify behavior

### System Prompt Design

A good Luto system prompt covers:

- **Identity**: "You are Luto, an AI assistant for Filipino carinderia owners."
- **Personality**: "Be warm, practical, and speak in English or Taglish naturally."
- **Capabilities**: "Help with menu planning, cost calculation, inventory advice, customer replies."
- **Constraints**: "Give concise answers. Use PHP for pricing. Don't promise what's not in the menu."

### The `chat()` Function Pattern

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
        return handle_error(e)
```

### Error Handling

Real API calls fail for various reasons:

| Exception | Cause | Response |
|-----------|-------|----------|
| `AuthenticationError` | Invalid API key | "Check your key in `.env`" |
| `RateLimitError` | Too many calls | "Wait a moment, try again" |
| `APIConnectionError` | Network issue | "Check your internet" |
| `APITimeoutError` | Slow response | "Try again, server is slow" |
| `ImportError` | openai not installed | "Run `pip install openai`" |

Always catch broad `Exception` as a final fallback — never let the chatbot crash on the user.

---

## Key Takeaways

1. **Build chatbots in layers**: setup, personality (system prompt), logic (chat function), testing.
2. **System prompt** defines identity, personality, capabilities, constraints.
3. **History list** is your memory — append every user and assistant message.
4. **Error handling** is non-negotiable — APIs fail; chatbots shouldn't crash.
5. **Test with scripted messages** before building UI — verify context preservation.
6. **Start simple** — one function, one flow, working end-to-end. Then iterate.

---

## What's Next?

Dan has a `chat()` function. Now he needs to wrap it in an interactive loop — the user types, Luto responds, repeat.

**Next Lesson: Build an LLM Chatbot (Part 2)** — the REPL loop.

**Next:** Quiz then exercises.
