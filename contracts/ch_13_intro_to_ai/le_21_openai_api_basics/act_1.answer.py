# openai_basics.py
# ============================================
# FIRST OPENAI CALL — Full Solution
# by Dan Santos
# ============================================

import os
import random


class MockChatCompletions:
    def create(self, model, messages, temperature=0.7, max_tokens=300, **kwargs):
        last = messages[-1]["content"].lower() if messages else ""

        # Deterministic-ish responses with temperature variation
        responses = []
        if "rainy" in last and "cook" in last:
            responses = [
                "Sinigang na baboy! The sour hot broth is perfect for rainy weather.",
                "Try Sinigang na Hipon — rainy days call for hot soup.",
                "Nilagang Baka. Warm, hearty, cures the rainy blues.",
            ]
        elif "how much" in last:
            responses = [
                "For 10 people: 2.5 kg pork, 1 pack sinigang mix, P180-220 total ingredients.",
                "About P220 in ingredients. Sells for P650. Profit: P430.",
                "Plan for 1 cup rice + 200g protein per person. 10 people = 2kg protein.",
            ]
        elif "how long" in last or "time" in last:
            responses = [
                "Sinigang: 1 hour total. 20 min prep + 40 min simmer.",
                "About an hour. Start rice 20 min in.",
            ]
        elif "budget" in last or "cheap" in last:
            responses = ["Tortang talong + rice: under P40 per serving. Filling and affordable."]
        elif "adobo" in last:
            responses = ["Adobo — marinate overnight in vinegar + soy + garlic. Never fails."]
        else:
            responses = ["Try Adobo today. Simple, reliable, crowd-pleaser."]

        # Temperature affects selection: high temp = more random
        if temperature < 0.3:
            reply = responses[0]
        elif temperature > 1.0 and len(responses) > 1:
            reply = random.choice(responses)
        else:
            reply = responses[0] if random.random() < 0.7 else random.choice(responses)

        class Response:
            class Choice:
                class Msg:
                    def __init__(self, c): self.content = c
                def __init__(self, c): self.message = self.Msg(c)
            class Usage:
                def __init__(self, n): self.total_tokens = n
            def __init__(self, c, tokens):
                self.choices = [self.Choice(c)]
                self.usage = self.Usage(tokens)

        # Rough token estimate: 1 token ~= 4 chars
        total = sum(len(m["content"]) for m in messages) // 4 + len(reply) // 4
        return Response(reply, total)


class MockOpenAI:
    def __init__(self):
        self.chat = type("ChatNS", (), {})()
        self.chat.completions = MockChatCompletions()


# Task 1: Client setup
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
print("  OPENAI API BASICS")
print(f"  Mode: {'MOCK (offline demo)' if MOCK_MODE else 'LIVE API'}")
print("=" * 55)

SYSTEM = "You are Luto, a friendly Filipino carinderia assistant. Be warm, concise, and practical."

# Task 2: First call
print("\n-- Task 2: First call --")
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "system", "content": SYSTEM},
        {"role": "user", "content": "What should I cook for a rainy Friday?"},
    ],
    temperature=0.7,
)
print(f"   Luto: {response.choices[0].message.content}")
print(f"   Tokens: {response.usage.total_tokens}")

# Task 3: Temperature experiments
print("\n-- Task 3: Temperature experiments --")
for temp in [0.0, 0.7, 1.2]:
    r = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": SYSTEM},
            {"role": "user", "content": "What's a good rainy-day dish?"},
        ],
        temperature=temp,
    )
    print(f"   temp={temp}: {r.choices[0].message.content[:70]}")

# Task 4: Multi-turn conversation
print("\n-- Task 4: Multi-turn conversation --")
history = [{"role": "system", "content": SYSTEM}]
total_tokens = 0

def ask(user_msg):
    global total_tokens
    history.append({"role": "user", "content": user_msg})
    r = client.chat.completions.create(model="gpt-3.5-turbo", messages=history)
    reply = r.choices[0].message.content
    history.append({"role": "assistant", "content": reply})
    total_tokens += r.usage.total_tokens
    return reply

print(f"   User: 'What should I cook for a rainy Friday?'")
print(f"   Luto: {ask('What should I cook for a rainy Friday?')}")
print(f"\n   User: 'How much for 10 people?'")
print(f"   Luto: {ask('How much for 10 people?')}")
print(f"\n   User: 'How long will it take?'")
print(f"   Luto: {ask('How long will it take?')}")

print(f"\n   History length: {len(history)} messages")

# Task 5: Token budget
print(f"\n-- Task 5: Token Budget Tracker --")
print(f"   Total tokens used: {total_tokens}")
print(f"   Approx cost:       P{total_tokens * 0.00015:.4f}")
print(f"   Budget remaining:  plenty (P500 ~= ~500K tokens)")

if total_tokens > 100_000:
    print(f"   ⚠️  High usage. Consider caching responses.")
