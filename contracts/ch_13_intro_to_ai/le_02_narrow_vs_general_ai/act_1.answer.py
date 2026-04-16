# ============================================
# AI SYSTEM CLASSIFIER v2.0 — with Quiz Mode
# by Dan Santos
# ============================================

import random

ai_systems = {
    "grab": {
        "type": "Narrow AI",
        "what_it_does": "Optimizes routes and matches riders to drivers",
        "philippine_context": "Used by millions of Filipinos daily for transportation"
    },
    "gcash fraud detection": {
        "type": "Narrow AI",
        "what_it_does": "Detects suspicious transactions to prevent scams",
        "philippine_context": "Protects over 80 million GCash users in the Philippines"
    },
    "shopee recommendations": {
        "type": "Narrow AI",
        "what_it_does": "Suggests products based on your browsing and purchase history",
        "philippine_context": "Why you end up buying things you didn't plan to during 9.9 sale"
    },
    "siri": {
        "type": "Narrow AI",
        "what_it_does": "Answers voice commands and questions",
        "philippine_context": "Works on iPhone — still struggles with Filipino names though"
    },
    "spam filter": {
        "type": "Narrow AI",
        "what_it_does": "Filters unwanted emails and messages",
        "philippine_context": "Catches those 'You won a prize!' scam texts"
    },
    "chatgpt": {
        "type": "Narrow AI",
        "what_it_does": "Generates text responses based on prompts",
        "philippine_context": "Popular tool among Filipino students — still can't drive!"
    },
    "google translate": {
        "type": "Narrow AI",
        "what_it_does": "Translates text between languages including Filipino",
        "philippine_context": "Now supports Filipino/Tagalog and Cebuano"
    },
    "face unlock": {
        "type": "Narrow AI",
        "what_it_does": "Recognizes your face to unlock your phone",
        "philippine_context": "Works on most smartphones used in the Philippines"
    },
    "waze": {
        "type": "Narrow AI",
        "what_it_does": "Predicts traffic and suggests the fastest route",
        "philippine_context": "Essential for surviving EDSA traffic"
    },
    "youtube recommendations": {
        "type": "Narrow AI",
        "what_it_does": "Suggests videos based on your watch history",
        "philippine_context": "Why you're up at 3 AM watching random videos"
    },
    "spotify discover weekly": {
        "type": "Narrow AI",
        "what_it_does": "Creates a personalized playlist every Monday based on listening habits",
        "philippine_context": "How it knows you love OPM and SB19"
    },
    "maya fraud detection": {
        "type": "Narrow AI",
        "what_it_does": "Monitors transactions for fraudulent activity",
        "philippine_context": "Protecting Maya (formerly PayMaya) users from scams"
    },
    "canva magic design": {
        "type": "Narrow AI",
        "what_it_does": "Auto-generates design layouts from your content",
        "philippine_context": "Every Filipino student's go-to for presentations"
    },
    "tesla autopilot": {
        "type": "Narrow AI",
        "what_it_does": "Assists with driving tasks like lane-keeping and parking",
        "philippine_context": "Not in PH yet, but still just Narrow AI!"
    },
    "google photos face grouping": {
        "type": "Narrow AI",
        "what_it_does": "Groups photos by recognizing faces of people",
        "philippine_context": "Knows your family reunion photos from your barkada pics"
    },
}

def lookup_mode():
    """Original lookup mode"""
    print("\nAvailable AI systems:")
    for i, name in enumerate(ai_systems, 1):
        print(f"  {i:2d}. {name.title()}")

    print()
    while True:
        user_input = input("Enter an AI system (or 'back' to return): ").lower().strip()
        if user_input == "back":
            return

        if user_input in ai_systems:
            system = ai_systems[user_input]
            print(f"\n  🤖 {user_input.title()}")
            print(f"  Type: {system['type']}")
            print(f"  What it does: {system['what_it_does']}")
            print(f"  PH context: {system['philippine_context']}")
            print(f"  Can it do OTHER things? ❌ Nope!\n")
        else:
            print(f"  Not in database. But if it exists today → Narrow AI!\n")

def quiz_mode():
    """Quiz mode — test your knowledge!"""
    systems_list = list(ai_systems.items())
    random.shuffle(systems_list)

    # Pick 5 questions
    quiz_items = systems_list[:5]
    score = 0

    print("\n🧠 QUIZ MODE — 5 Questions")
    print("For each AI system, type: narrow, general, or super\n")

    for i, (name, info) in enumerate(quiz_items, 1):
        print(f"  Question {i}/5: {name.title()}")
        print(f"  → {info['what_it_does']}")
        answer = input("  Is this Narrow AI, General AI, or Super AI? ").lower().strip()

        correct = "narrow"  # They're ALL narrow AI!
        if correct in answer:
            score += 1
            print(f"  ✅ Correct! {name.title()} is Narrow AI.\n")
        else:
            print(f"  ❌ Wrong! {name.title()} is Narrow AI.")
            print(f"  Remember: ALL current AI is Narrow AI!\n")

    print(f"{'=' * 40}")
    print(f"  Your Score: {score}/5")
    print(f"{'=' * 40}")

    if score == 5:
        print("  🏆 Perfect! You know it — they're all Narrow AI!")
    elif score >= 3:
        print("  👍 Great job! Just a bit more review needed.")
    else:
        print("  📚 Key lesson: if it exists today, it's Narrow AI!")
    print()

# Main menu
print("=" * 50)
print("  AI SYSTEM CLASSIFIER v2.0")
print("  Now with Quiz Mode!")
print("=" * 50)

while True:
    print("\nChoose a mode:")
    print("  1. Lookup Mode — classify an AI system")
    print("  2. Quiz Mode — test your knowledge (5 questions)")
    print("  3. Quit")

    choice = input("\nYour choice (1/2/3): ").strip()

    if choice == "1":
        lookup_mode()
    elif choice == "2":
        quiz_mode()
    elif choice == "3":
        print("\nThanks for learning! Remember: ALL current AI = Narrow AI. 🧠")
        break
    else:
        print("Please enter 1, 2, or 3.")
