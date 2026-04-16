# openai_basics.py
# ============================================
# FIRST OPENAI CALL (with mock fallback)
# by: <Your Name>
# ============================================
# Run: python act_1.py
# If you have an API key in .env it will use the real API.
# Otherwise it falls back to a mock client for offline dev.

import os
import random


class MockOpenAI:
    """Drop-in mock for offline development."""

    def chat_completions_create(self, model, messages, temperature=0.7, **kwargs):
        last = messages[-1]["content"].lower() if messages else ""
        if "rainy" in last and "cook" in last:
            reply = "Sinigang na baboy! The sour hot broth is perfect for rainy weather."
        elif "adobo" in last:
            reply = "Adobo is a classic — never wrong. Marinate overnight for max flavor."
        elif "budget" in last or "cheap" in last:
            reply = "Tortang talong + rice hits under P40 per serving. Budget-friendly!"
        else:
            reply = "Try Adobo today. Simple, reliable, crowd-pleaser."

        # Simulate the OpenAI response shape loosely
        class Response:
            class Choice:
                class Msg:
                    def __init__(self, c): self.content = c
                def __init__(self, c): self.message = self.Msg(c)
            class Usage:
                total_tokens = random.randint(80, 200)
            def __init__(self, c):
                self.choices = [self.Choice(c)]
                self.usage = self.Usage()
        return Response(reply)


# TODO: Task 1 — Set up real or mock client
# If OPENAI_API_KEY is set AND the openai package is importable,
# use real OpenAI. Otherwise use MockOpenAI.


# TODO: Task 2 — First call
# Use system prompt "You are Luto, a friendly Filipino carinderia assistant."
# Ask "What should I cook for a rainy Friday?"


# TODO: Task 3 — Temperature experiments
# Run the same prompt at temperature = 0.0, 0.7, 1.2


# TODO: Task 4 — Multi-turn conversation
# Build a `history` list. Ask 3 related questions in sequence.
# Show how the list grows with each exchange.


# TODO: Task 5 — Token budget tracker
# Track total tokens across calls. Warn if > 100,000.
