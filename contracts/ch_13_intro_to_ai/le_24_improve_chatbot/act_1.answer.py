# chatbot_v3.py
# ============================================
# LUTO v3 — Full Solution (improved)
# by Dan Santos
# ============================================

import os

MENU_DATABASE = {
    "Adobo":       {"cost": 35, "price": 60, "best_days": ["Mon-Fri"]},
    "Sinigang":    {"cost": 38, "price": 65, "best_days": ["rainy"]},
    "Bistek":      {"cost": 42, "price": 70, "best_days": ["Fri-Sat"]},
    "Tinola":      {"cost": 28, "price": 55, "best_days": ["any"]},
    "Kare-Kare":   {"cost": 55, "price": 95, "best_days": ["Sun", "payday"]},
    "Lugaw":       {"cost": 12, "price": 35, "best_days": ["Mon", "cold"]},
    "Turon":       {"cost": 8,  "price": 20, "best_days": ["merienda"]},
    "Halo-Halo":   {"cost": 30, "price": 60, "best_days": ["hot"]},
}


def build_system_prompt():
    menu_text = "\n".join(
        f"- {name}: ingredient cost P{d['cost']}, sell at P{d['price']}, "
        f"best on {', '.join(d['best_days'])}"
        for name, d in MENU_DATABASE.items()
    )
    return f"""You are Luto, AI assistant for Tita Malou's carinderia in Marikina.

Your actual menu and pricing:
{menu_text}

Rules:
- Keep answers concise (2-3 sentences unless asked for detail)
- Use PHP for all prices
- Mirror the user's language — if they type Taglish, respond in Taglish
- Avoid MBA jargon — Mama is street-smart, not corporate
- If asked about items NOT in the menu, say you'd need to check
"""


LUTO_SYSTEM_PROMPT = build_system_prompt()
MAX_HISTORY_PAIRS = 8


class MockOpenAI:
    class chat:
        class completions:
            @staticmethod
            def create(model, messages, **kwargs):
                last = messages[-1]["content"].lower() if messages else ""
                if "magkano" in last or "how much" in last:
                    reply = "Para sa Sinigang: benta P65, cost P38. Profit P27 per serving."
                elif "rainy" in last or "ulan" in last:
                    reply = "Sinigang na baboy talaga. Mainit, masarap, bilib customers sa rainy day."
                elif "payday" in last:
                    reply = "Kare-Kare! Payday special — sells at P95, cost P55, profit P40 per plate."
                elif "thank" in last or "salamat" in last:
                    reply = "Walang anuman! Balik ka, ha?"
                else:
                    reply = "Adobo pa rin ang safe bet. Affordable, masarap, paborito ng lahat."

                class R:
                    class Choice:
                        class Msg:
                            def __init__(s, c): s.content = c
                        def __init__(s, c): s.message = s.Msg(c)
                    def __init__(s, c): s.choices = [s.Choice(c)]
                return R(reply)


client = MockOpenAI()
history = [{"role": "system", "content": LUTO_SYSTEM_PROMPT}]


def trim_history():
    global history
    max_msgs = 1 + MAX_HISTORY_PAIRS * 2
    if len(history) > max_msgs:
        history = [history[0]] + history[-(MAX_HISTORY_PAIRS * 2):]


def handle_api_error(e):
    error_type = e.__class__.__name__
    if "Auth" in error_type:
        return "Authentication failed. Check `.env` for a valid OPENAI_API_KEY."
    if "RateLimit" in error_type:
        return "Rate limited. Wait 20 seconds and try again."
    if "Connection" in error_type or "Timeout" in error_type:
        return "Connection issue. Check your internet, then retry."
    return f"Unexpected error: {error_type}: {e}"


def chat(user_message):
    history.append({"role": "user", "content": user_message})
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo", messages=history)
        reply = response.choices[0].message.content
        history.append({"role": "assistant", "content": reply})
        trim_history()
        return reply
    except Exception as e:
        return f"[Luto] {handle_api_error(e)}"


def suggest_command(day, weather):
    print(f"\n  💡 SUGGESTIONS for {day}, {weather}")
    results = []
    for name, d in MENU_DATABASE.items():
        score = 0
        if weather in d["best_days"]:
            score += 3
        if day in " ".join(d["best_days"]):
            score += 2
        profit = d["price"] - d["cost"]
        score += profit / 10
        results.append((name, score, d))
    results.sort(key=lambda x: x[1], reverse=True)
    for name, score, d in results[:3]:
        proj_qty = 15 + score
        proj_rev = int(proj_qty * d["price"])
        print(f"     - {name}: expect ~{int(proj_qty)} sold, revenue P{proj_rev}")


def cost_command(dish):
    d = MENU_DATABASE.get(dish)
    if not d:
        print(f"  ❌ {dish} not in the menu database.")
        return
    profit = d["price"] - d["cost"]
    margin = profit / d["cost"] * 100
    print(f"\n  💰 {dish}")
    print(f"     Ingredient cost:  P{d['cost']}")
    print(f"     Selling price:    P{d['price']}")
    print(f"     Profit / serving: P{profit} ({margin:.0f}% margin)")


def summary_command():
    topics = {"menu": 0, "pricing": 0, "inventory": 0, "customer": 0, "other": 0}
    for m in history:
        if m["role"] != "user":
            continue
        c = m["content"].lower()
        if "menu" in c or "dish" in c or "cook" in c or "suggest" in c:
            topics["menu"] += 1
        elif "magkano" in c or "price" in c or "cost" in c or "profit" in c:
            topics["pricing"] += 1
        elif "stock" in c or "inventory" in c or "ingredient" in c:
            topics["inventory"] += 1
        elif "customer" in c or "reply" in c:
            topics["customer"] += 1
        else:
            topics["other"] += 1
    print("\n  📊 Topics in this conversation:")
    for t, c in topics.items():
        if c > 0:
            print(f"     {t:10} {c} question(s)")


# ============================================
# DEMO
# ============================================
print("=" * 55)
print("  LUTO v3 — Improved based on user feedback")
print("=" * 55)

SCRIPT = [
    ("chat", "Magkano ang Sinigang?"),
    ("chat", "Ano gagawin ko sa rainy Monday?"),
    ("command", "/cost Kare-Kare"),
    ("command", "/cost Ramen"),  # not in menu — tests graceful handling
    ("command", "/suggest Friday payday"),
    ("chat", "Ano best para sa payday?"),
    ("command", "/summary"),
]

for kind, msg in SCRIPT:
    print(f"\nYou: {msg}")
    if kind == "command":
        parts = msg.split(maxsplit=1)
        head = parts[0].lower()
        if head == "/cost":
            cost_command(parts[1] if len(parts) > 1 else "")
        elif head == "/suggest":
            args = (parts[1] if len(parts) > 1 else "Friday rainy").split()
            day = args[0] if args else "Friday"
            weather = args[1] if len(args) > 1 else "rainy"
            suggest_command(day, weather)
        elif head == "/summary":
            summary_command()
    else:
        reply = chat(msg)
        print(f"Luto: {reply}")

print(f"\n\n  History after trim: {len(history)} messages (max {1 + MAX_HISTORY_PAIRS * 2})")
