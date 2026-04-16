## Previously on Dan's AI Journey...

Dan mastered prompt engineering with the RCTFC framework and built 4 reusable prompt templates for Luto.

---

## Background Story

Kuya JM invited Dan to his apartment in Makati for a Saturday crash course on APIs. Baby JM Jr. was napping. Coffee was brewing.

> **Kuya JM:** *"APIs are like restaurants. You are the customer (your program). The waiter is the API — takes your order, brings it to the kitchen. The kitchen is the server. You don't see the cooking. You just submit a request and get a response."*
>
> **Kuya JM:** *"HTTP methods = verbs. GET = 'fetch menu.' POST = 'place new order.' PUT = 'update order.' DELETE = 'cancel order.' Status codes = waiter's reply: 200 OK, 401 'show ID', 404 'no such table,' 429 'too many orders, slow down,' 500 'kitchen exploded.'"*
>
> **Kuya JM:** *"JSON is the language. Python dict ↔ JSON is a simple conversion. That's how programs exchange data. And API keys are your credit card — prove you're allowed to order, and they track your usage."*

Dan built a mock carinderia API that afternoon — with endpoints for menu, orders, and recommendations. He also made real HTTP calls to httpbin.org (a testing API) to see actual GET/POST/status codes. By sundown he understood API mechanics from both sides: client and server.

Kuya JM gave Dan a P500 OpenAI API key. "Use it wisely. Each message costs fractions of a peso, but it adds up if you spam."

---

## Theory & Lecture Content

### What is an API?

**API = Application Programming Interface.** A way for programs to communicate with each other.

```
Your code ---[request]---> API ---[answer]---> Your code
```

### HTTP Methods

| Method | Purpose | Carinderia analogy |
|--------|---------|--------------------|
| GET | Fetch data | "Show me the menu" |
| POST | Send / create | "Place a new order" |
| PUT | Update | "Change my order" |
| DELETE | Remove | "Cancel my order" |

### Status Codes

| Code | Meaning | Carinderia analogy |
|------|---------|--------------------|
| 200 | OK — success | Order received |
| 201 | Created | Reservation confirmed |
| 400 | Bad Request | Mumbled order |
| 401 | Unauthorized | No ID shown |
| 404 | Not Found | That dish doesn't exist |
| 429 | Rate Limited | Too many orders at once |
| 500 | Server Error | Kitchen broke down |

### JSON — The Language of APIs

```json
{
  "order_id": 1234,
  "customer": "Dan",
  "items": [
    {"name": "Adobo", "qty": 1, "price": 60}
  ],
  "total": 60
}
```

In Python:
```python
import json
data = json.loads(json_string)     # JSON -> dict
text = json.dumps(data)             # dict -> JSON
```

Key differences: JSON uses `true/false/null` (not Python's `True/False/None`), strings must be double-quoted.

### Python `requests` Library

```python
import requests

# GET
r = requests.get("https://api.example.com/menu")
print(r.status_code)    # 200
data = r.json()

# POST with JSON body
r = requests.post(
    "https://api.example.com/orders",
    json={"dish": "Adobo", "qty": 2},
    headers={"Authorization": "Bearer YOUR_API_KEY"},
)
print(r.json())
```

### API Key Security

**NEVER:**
- Hardcode API keys in your code
- Commit keys to git
- Share keys in public forums

**DO:**
- Use environment variables: `os.environ.get("OPENAI_API_KEY")`
- Use `.env` files (gitignored)
- Rotate keys if exposed

---

## Dan's Journal

> **April 5, 2026 — Kuya JM's apartment**
>
> APIs are just restaurants. That mental model made everything click.
>
> Built a mock carinderia API with 6 endpoints: GET /menu, GET /menu/<item>, POST /order, GET /orders, GET /recommendation, and GET /health. Also called real APIs — httpbin.org, advice slip — and saw actual HTTP status codes, JSON bodies, headers.
>
> Kuya JM gave me a P500 OpenAI key. He wrapped it in a stern lecture: "Never commit this. Use os.environ. Delete the key from your machine if you're done. If it leaks, someone will drain it in minutes." I nodded. Created a `.env` file. Added it to `.gitignore`.
>
> Tomorrow: first real OpenAI API call. The hackathon countdown is real.

---

## Key Takeaways

1. **API = the "waiter"** between your code and a remote service.
2. **HTTP methods**: GET (fetch), POST (create), PUT (update), DELETE (remove).
3. **Status codes** tell you what happened: 200 OK, 401 Unauthorized, 429 Rate Limited, 500 Server Error.
4. **JSON** is the universal data format for APIs.
5. **Python's `requests` library** is the go-to for API calls.
6. **NEVER commit API keys** — use environment variables and `.env` files.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **GCash** | jee-CASH | PH's most popular mobile wallet; has a dev API too. |
| **Kare-Kare** | kah-REH kah-REH | Peanut-based celebration stew. |
| **Tinola** | tee-NOH-lah | Light ginger-chicken soup. |

---

## What's Next?

Dan has an API key. Time to make his first real OpenAI API call.

**Next Lesson: OpenAI API Basics** — Dan's first real LLM interaction from his own code.

**Next:** Quiz then exercises.
