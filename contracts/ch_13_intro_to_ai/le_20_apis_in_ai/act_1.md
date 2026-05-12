# API Lab — Mock Carinderia API

Build a mock carinderia API (no external service needed) that demonstrates all HTTP verbs, status codes, and JSON handling.

---

## Task 1: JSON Round-Trip

```python
import json

data = {"order_id": 1234, "items": ["Adobo", "Sinigang"], "total": 125.50}
text = json.dumps(data)              # dict → JSON string
back = json.loads(text)              # JSON string → dict
```

---

## Task 2: Build MockCarinderiaAPI Class

6 endpoints:
- `GET /menu` — return list of dishes
- `GET /menu/<item>` — return one dish (or 404)
- `POST /order` — create an order (returns 201 + order_id)
- `GET /orders` — return all orders + total revenue
- `GET /recommendation` — weather-based suggestion
- `GET /health` — simple heartbeat

Each method returns `(status_code, response_dict)`.

---

## Task 3: CarinderiaClient Wrapper

A nice client interface over the mock API:

```python
client = CarinderiaClient(api)
menu = client.get_menu()
client.place_order("Adobo", qty=2)
```

---

## Task 4: Real API Calls (Optional)

If you have internet, call a real free API:

```python
import requests
r = requests.get("https://api.adviceslip.com/advice")
print(r.status_code)
print(r.json())
```

---

## Challenge: Smart Recommendation Endpoint

Add a `/smart-recommendation` endpoint that factors in weather, budget, is_payday, and time_of_day.

---

## What You've Learned

- JSON serialization with `json.dumps/loads`
- HTTP methods and status codes
- Building an API surface in Python
- Client wrappers over raw API calls
- Why secrets go in environment variables, never in code

Next up: **OpenAI API Basics** — Dan's first real LLM call.
