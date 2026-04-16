# chatbot.py
# ============================================
# LUTO — AI carinderia assistant (Part 1)
# by: <Your Name>
# ============================================

import os
import random


# TODO: Task 1 — Write LUTO_SYSTEM_PROMPT
LUTO_SYSTEM_PROMPT = """
You are Luto, an AI assistant for small Filipino carinderias.

Personality: warm, practical, speak English or Taglish naturally.
Capabilities:
- Menu planning based on weather and budget
- Cost calculation and pricing suggestions
- Inventory and stocking advice
- Customer reply drafting

Constraints:
- Keep answers under 4 sentences unless asked for detail
- Use PHP (₱) for all prices
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
                elif "how much" in last or "magkano" in last:
                    reply = "For 10 servings of sinigang: ~P220 in ingredients, sells at P650 total."
                elif "how long" in last:
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


# TODO: Task 2 — Set up client (real or mock fallback)
client = MockOpenAI()  # replace with OpenAI() if OPENAI_API_KEY is set


# TODO: Task 3 — Implement chat()
# history = [{"role": "system", "content": LUTO_SYSTEM_PROMPT}]
# def chat(user_message): ...


# TODO: Task 4 — Send 5 test messages and print the exchange


# TODO: Task 5 — Inspect history (first 3 + last 3 messages)
