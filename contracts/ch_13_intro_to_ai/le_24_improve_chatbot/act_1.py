# chatbot_v3.py
# ============================================
# LUTO v3 — Improved based on Tita Malou's feedback
# by: <Your Name>
# ============================================

import os

# Real data from Mama's carinderia
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


# TODO: Task 1 — LUTO_SYSTEM_PROMPT = build_system_prompt()


# TODO: Task 2 — trim_history() to keep only last MAX_HISTORY_PAIRS exchanges


# TODO: Task 3 — suggest_command(day, weather)


# TODO: Task 4 — cost_command(dish)


# TODO: Task 5 — handle_api_error(e) with specific helpful messages


# TODO: Build chat() that uses trim_history and handle_api_error


# TODO: Main loop (or scripted demo) that tests:
#   - Regular question
#   - /suggest Monday rainy
#   - /cost Sinigang
#   - Taglish question
