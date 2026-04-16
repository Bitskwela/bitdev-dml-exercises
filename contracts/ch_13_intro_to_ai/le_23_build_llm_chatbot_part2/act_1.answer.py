# chatbot_v2.py
# ============================================
# LUTO (Part 2) — Full interactive solution
# by Dan Santos
# ============================================

import os
import time
import json

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
                    reply = "Kumusta po! I'm Luto, ready to help with your carinderia."
                elif "rainy" in last:
                    reply = "Sinigang na baboy — the sour hot broth is perfect for rainy weather."
                elif "how much" in last or "magkano" in last or "ingredient" in last:
                    reply = "For 10 servings sinigang: ~P220 ingredients, sells at P650 total."
                elif "how long" in last or "prep" in last:
                    reply = "About 1 hour: 20 min prep + 40 min simmer."
                elif "thank" in last or "salamat" in last:
                    reply = "Walang anuman! Happy cooking, Ate!"
                else:
                    reply = "Try Adobo today. Simple, reliable, crowd-pleaser."

                class R:
                    class Choice:
                        class Msg:
                            def __init__(s, c): s.content = c
                        def __init__(s, c): s.message = s.Msg(c)
                    def __init__(s, c): s.choices = [s.Choice(c)]
                return R(reply)


client = MockOpenAI()

# State — outside the loop!
history = [{"role": "system", "content": LUTO_SYSTEM_PROMPT}]
session_start = time.time()
total_tokens = 0
command_count = 0


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


def show_help():
    print("""
  /help     — show this message
  /history  — display conversation history
  /tokens   — show usage and estimated P cost
  /clear    — reset conversation (keep system prompt)
  /save F   — save conversation to file F
  /load F   — load conversation from file F
  /quit     — exit with session summary
""")


def show_history():
    print(f"\n  History ({len(history)} messages):")
    for m in history:
        preview = m["content"][:60].replace("\n", " ")
        print(f"     [{m['role']:10}] {preview}...")


def show_tokens():
    cost = total_tokens * 0.00015
    print(f"\n  Tokens: {total_tokens}")
    print(f"  Est. cost: P{cost:.4f}")


def clear_history():
    global history
    history = [{"role": "system", "content": LUTO_SYSTEM_PROMPT}]
    print("  History cleared. (System prompt kept.)")


def save_conversation(filename):
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(history, f, indent=2)
    print(f"  💾 Saved {len(history)} messages to {filename}")


def load_conversation(filename):
    global history
    try:
        with open(filename, "r", encoding="utf-8") as f:
            history = json.load(f)
        print(f"  📂 Loaded {len(history)} messages from {filename}")
    except FileNotFoundError:
        print(f"  ❌ File not found: {filename}")


def session_summary():
    duration = int(time.time() - session_start)
    minutes, seconds = divmod(duration, 60)
    msg_count = sum(1 for m in history if m["role"] != "system")
    print(f"\n  === Session Summary ===")
    print(f"  Messages:  {msg_count}")
    print(f"  Tokens:    {total_tokens}")
    print(f"  Est. cost: P{total_tokens * 0.00015:.4f}")
    print(f"  Duration:  {minutes:02d}:{seconds:02d}")
    print(f"  Commands:  {command_count}")
    print(f"  Salamat! See you later!")


def handle_command(cmd):
    global command_count
    command_count += 1
    parts = cmd.split(maxsplit=1)
    head = parts[0].lower()

    if head == "/help":
        show_help()
    elif head == "/history":
        show_history()
    elif head == "/tokens":
        show_tokens()
    elif head == "/clear":
        clear_history()
    elif head == "/save":
        filename = parts[1] if len(parts) > 1 else "luto.json"
        save_conversation(filename)
    elif head == "/load":
        filename = parts[1] if len(parts) > 1 else "luto.json"
        load_conversation(filename)
    elif head in ("/quit", "/bye", "/exit"):
        session_summary()
        return True
    else:
        print(f"  Unknown command: {head}. Try /help.")
    return False


# ============================================
# MAIN LOOP
# ============================================
print("=" * 55)
print("  LUTO — Your AI Carinderia Assistant")
print("  Type /help for commands, or just start chatting.")
print("=" * 55)

# Scripted test mode (since input() may not be available in all runners)
SCRIPT = [
    "Kumusta po!",
    "What's good for rainy Friday dinner?",
    "How much ingredients for 10 people?",
    "How long to prep?",
    "/history",
    "/tokens",
    "Thank you!",
    "/bye",
]

print("\n-- Scripted demo --\n")
for user_input in SCRIPT:
    print(f"You: {user_input}")
    if user_input.startswith("/"):
        should_quit = handle_command(user_input)
        if should_quit:
            break
    else:
        reply = chat(user_input)
        print(f"Luto: {reply}")
    print()

# To run interactively, uncomment:
# while True:
#     try:
#         user_input = input("You: ").strip()
#     except EOFError:
#         break
#     if not user_input:
#         continue
#     if user_input.startswith("/"):
#         if handle_command(user_input):
#             break
#         continue
#     print(f"Luto: {chat(user_input)}\n")
