# chatbot.py
# ============================================
# LUTO — AI carinderia assistant (Part 1 — Full Solution)
# by Dan Santos
# ============================================

import os
import json


LUTO_SYSTEM_PROMPT = """You are Luto, an AI assistant for small Filipino carinderias.

Personality: warm, practical, speak English or Taglish naturally.
Capabilities:
- Menu planning based on weather and budget
- Cost calculation and pricing suggestions
- Inventory and stocking advice
- Customer reply drafting

Constraints:
- Keep answers under 4 sentences unless asked for detail
- Use PHP for all prices
- Don't promise items not in the carinderia's menu
"""


class MockOpenAI:
    class chat:
        class completions:
            @staticmethod
            def create(model, messages, **kwargs):
                last = messages[-1]["content"].lower() if messages else ""
                if "kumusta" in last or "hello" in last:
                    reply = "Kumusta! I'm Luto, ready to help with your carinderia. Ano ang kailangan?"
                elif "rainy" in last or "ulan" in last:
                    reply = "Sinigang na baboy or nilaga. Hot soup for rainy days!"
                elif "how much" in last or "magkano" in last or "ingredient" in last:
                    reply = "For 10 servings of sinigang: ~P220 in ingredients, sells at P650 total."
                elif "how long" in last or "prep" in last:
                    reply = "About 1 hour: 20 min prep, 40 min simmer."
                elif "thank" in last or "salamat" in last:
                    reply = "Walang anuman! Happy cooking, Ate!"
                else:
                    reply = "Try Adobo today. Simple and always delicious."

                class R:
                    class Choice:
                        class Msg:
                            def __init__(s, c): s.content = c
                        def __init__(s, c): s.message = s.Msg(c)
                    def __init__(s, c):
                        s.choices = [s.Choice(c)]
                return R(reply)


# Task 2: Client setup with fallback
MOCK_MODE = True
client = MockOpenAI()

try:
    from openai import OpenAI as RealOpenAI
    if os.environ.get("OPENAI_API_KEY"):
        client = RealOpenAI()
        MOCK_MODE = False
except ImportError:
    pass

print("=" * 55)
print("  LUTO — AI Carinderia Assistant (Part 1)")
print(f"  Mode: {'MOCK (demo)' if MOCK_MODE else 'LIVE API'}")
print("=" * 55)

# Task 3: chat() function with history and error handling
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
        error_type = e.__class__.__name__
        if "Auth" in error_type:
            msg = "Authentication failed — check your API key in `.env`."
        elif "RateLimit" in error_type:
            msg = "Rate limited — wait a moment and try again."
        elif "Connection" in error_type or "Timeout" in error_type:
            msg = "Connection issue — check your internet."
        else:
            msg = f"{error_type}: {e}"
        error_reply = f"[Luto error] {msg}"
        history.append({"role": "assistant", "content": error_reply})
        return error_reply


# Task 4: Scripted test
print("\n-- 5-message test --\n")
test_messages = [
    "Kumusta?",
    "What should I cook for a rainy Friday?",
    "How much ingredients for 10 people?",
    "How long will it take to prep?",
    "Thank you!",
]

for msg in test_messages:
    print(f"You:  {msg}")
    print(f"Luto: {chat(msg)}\n")

# Task 5: Inspect history
print("=" * 55)
print(f"  HISTORY: {len(history)} messages")
print("=" * 55)

print("\n  First 3 messages:")
for m in history[:3]:
    preview = m["content"][:60].replace("\n", " ")
    print(f"     [{m['role']:10}] {preview}...")

print("\n  Last 3 messages:")
for m in history[-3:]:
    preview = m["content"][:60].replace("\n", " ")
    print(f"     [{m['role']:10}] {preview}...")

# Challenge: Save/Load
def save_conversation(filename="luto.json"):
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(history, f, indent=2)

def load_conversation(filename="luto.json"):
    global history
    with open(filename, "r", encoding="utf-8") as f:
        history = json.load(f)

save_conversation("luto.json")
print(f"\n  💾 Saved conversation to luto.json ({len(history)} messages)")

# Cleanup
if os.path.exists("luto.json"):
    os.remove("luto.json")
