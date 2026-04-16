## Previously on Dan's AI Journey...

Dan built a mock carinderia API with full HTTP semantics — learning the mechanics of client/server communication.

---

## Background Story

Six PM. University computer lab. Empty except for Dan and the hum of aging fluorescent lights. Three days until TechPinas. Dan had Kuya JM's OpenAI API key in a `.env` file. He had his prompt templates from Lesson 19. He had a working mock API from Lesson 20.

Time to make the real call.

```python
from openai import OpenAI
client = OpenAI()
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "system", "content": "You are a friendly carinderia expert named Luto."},
        {"role": "user", "content": "Should I cook sinigang tonight? It's raining."}
    ]
)
print(response.choices[0].message.content)
```

His hands shook. He pressed Enter.

Two seconds later:

> *"Yes! Sinigang is perfect for a rainy night — the sour broth warms the soul. If you have pork belly and fresh kangkong, go for sinigang na baboy. If you want something lighter, try sinigang na isda. Cook extra rice — this kind of weather makes people very hungry."*

Dan stared at the screen for ten seconds. *He had just made an AI talk to him from HIS code.* Not from ChatGPT's website. From Python. On his secondhand Acer laptop. In a dim Diliman computer lab.

This was it. This was real AI development.

He spent the next two hours experimenting: changing temperature, testing multi-turn conversations, tracking token usage against his P500 budget. By midnight he understood the full OpenAI API surface.

---

## Theory & Lecture Content

### OpenAI API Basics

```python
from openai import OpenAI
client = OpenAI()   # reads OPENAI_API_KEY from env

response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "system", "content": "personality / rules"},
        {"role": "user", "content": "the question"},
    ],
    temperature=0.7,
    max_tokens=300,
)
print(response.choices[0].message.content)
```

### Message Roles

| Role | Purpose |
|------|---------|
| **system** | Personality, rules, style (set once at start) |
| **user** | The actual question / input |
| **assistant** | AI's response (included in history for multi-turn) |

### Key Parameters

| Parameter | Range | Effect |
|-----------|-------|--------|
| `model` | model name | gpt-3.5-turbo (cheap/fast), gpt-4 (expensive/powerful) |
| `temperature` | 0.0–1.5 | 0 = focused, 1+ = creative/random |
| `max_tokens` | integer | Cap response length |
| `top_p` | 0–1 | Alternative to temperature (nucleus sampling) |

### Multi-Turn Conversation

LLMs are **stateless**. You must send the entire conversation history with every request:

```python
messages = [
    {"role": "system", "content": "You are Luto."},
    {"role": "user", "content": "What should I cook?"},
    {"role": "assistant", "content": "Sinigang is great for today."},
    {"role": "user", "content": "How much should I make?"},   # referencing "that"
]
response = client.chat.completions.create(model="gpt-3.5-turbo", messages=messages)
```

Without the history, the second question loses context.

### Tokens and Costs

- 1 token ≈ 0.75 words (English), less for other languages
- gpt-3.5-turbo: ~P0.01-0.02 per 1000 tokens
- Track usage: `response.usage.total_tokens`

A 20-message conversation at 100 tokens each = ~P0.04. Still cheap, but add up quickly at scale.

### Mock Client for Offline Dev

Don't burn API credits while coding. Use a mock client that returns deterministic/fake responses. Switch to the real client once everything works.

```python
class MockOpenAI:
    def chat(self, messages):
        last = messages[-1]["content"]
        if "sinigang" in last.lower():
            return "Yes — sinigang is perfect for today."
        return "Try Adobo — the classic."
```

---

## Dan's Journal

> **April 6, 2026 — Computer lab, 8 PM**
>
> I made AI talk to me from MY OWN CODE.
>
> First call: 2 seconds. Response: helpful, specific, warm. I stared for ten seconds. Then I yelled a quiet "YES" in the empty lab.
>
> Spent 2 hours exploring:
> - Temperature 0.0 = consistent, sometimes boring
> - Temperature 1.2 = creative, sometimes chaotic
> - Temperature 0.7 = sweet spot for chatbot
> - System prompt matters MORE than user prompt for personality
> - Multi-turn works if you send full history (LLMs are stateless!)
> - 50 messages = ~P5 in tokens. Not bad.
>
> Built a mock OpenAI client too — tests run offline, no tokens burned, fast CI. Only switch to real client for integration tests.

---

## Key Takeaways

1. **OpenAI API = HTTP API** with SDK wrapper. You send messages, get back completions.
2. **3 message roles**: system (personality), user (question), assistant (AI reply).
3. **Temperature** controls creativity: 0 = deterministic, 1.5 = wild.
4. **LLMs are stateless** — send full conversation history every request.
5. **Tokens cost money** — track `response.usage`. Cheap per call, but scales.
6. **Mock clients** let you develop without spending API credits.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Halo-Halo** | HAH-loh HAH-loh | Iconic shaved ice dessert. |
| **Tortang Talong** | tohr-TAHNG tah-LOHNG | Eggplant omelet — Filipino carinderia staple. |
| **Luto** | LOO-toh | "To cook" — and the name of Dan's chatbot. |

---

## What's Next?

Dan made a single API call. Now he needs to wire it into a real chatbot with conversation memory and error handling.

**Next Lesson: Build an LLM Chatbot (Part 1)** — the foundation of Luto.

**Next:** Quiz then exercises.
