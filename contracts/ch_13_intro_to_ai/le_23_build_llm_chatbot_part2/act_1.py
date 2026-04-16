# chatbot_v2.py
# ============================================
# LUTO (Part 2) — Interactive chatbot with commands
# by: <Your Name>
# ============================================

import os
import time
from datetime import datetime

LUTO_SYSTEM_PROMPT = """You are Luto, an AI assistant for small Filipino carinderias.
Be warm, practical, and speak English or Taglish naturally.
Capabilities: menu planning, pricing, inventory, customer replies.
Use PHP for prices. Keep answers concise (under 4 sentences) unless asked for detail.
"""


class MockOpenAI:
    class chat:
        class completions:
            @staticmethod
            def create(model, messages, **kwargs):
                last = messages[-1]["content"].lower() if messages else ""
                if "kumusta" in last:
                    reply = "Kumusta po! I'm Luto, ready to help."
                elif "rainy" in last:
                    reply = "Sinigang na baboy — perfect for rainy weather!"
                elif "how much" in last or "magkano" in last:
                    reply = "For 10 people: ~P220 ingredients, sells at P650."
                elif "how long" in last:
                    reply = "About 1 hour total."
                elif "thank" in last or "salamat" in last:
                    reply = "Walang anuman! Happy cooking!"
                else:
                    reply = "Try Adobo — classic and reliable."

                class R:
                    class Choice:
                        class Msg:
                            def __init__(s, c): s.content = c
                        def __init__(s, c): s.message = s.Msg(c)
                    def __init__(s, c): s.choices = [s.Choice(c)]
                return R(reply)


client = MockOpenAI()

# History lives OUTSIDE the loop (critical!)
history = [{"role": "system", "content": LUTO_SYSTEM_PROMPT}]
session_start = time.time()
total_tokens = 0


def chat(user_message):
    global total_tokens
    history.append({"role": "user", "content": user_message})
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo", messages=history)
        reply = response.choices[0].message.content
        history.append({"role": "assistant", "content": reply})
        total_tokens += len(user_message) // 4 + len(reply) // 4 + 30
        return reply
    except Exception as e:
        return f"[Error] {e}"


# TODO: Task 2 — Implement these command handlers:
# def show_help(): ...
# def show_history(): ...
# def show_tokens(): ...
# def clear_history(): ...


# TODO: Task 3 — Session stats tracker shown on /quit


# TODO: Task 4 — Main loop (while True with slash command routing)
# Tip: wrap input() in try/except (EOFError) so scripted/non-TTY runs don't crash


# TODO: Challenge — /save <file> and /load <file> commands
