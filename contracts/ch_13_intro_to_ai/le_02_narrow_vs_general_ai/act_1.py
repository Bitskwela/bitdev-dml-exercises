# ============================================
# AI SYSTEM CLASSIFIER
# by: <Your Name>
# ============================================
# Classify real AI systems as Narrow, General,
# or Super AI. Spoiler: they're ALL Narrow AI
# because that's the only kind that exists!
# ============================================

# TODO: Create a dictionary called `ai_systems`
# Each key is the system name (lowercase).
# Each value is another dictionary with:
#   "type": "Narrow AI",
#   "what_it_does": "...",
#   "philippine_context": "..."
#
# Start with these 3 examples, then add at least 5 more:

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
    # TODO: Add at least 5 more AI systems here!
    # Ideas: siri, spam filter, chatgpt, google translate,
    #        face unlock, waze, youtube recommendations,
    #        tiktok algorithm, lazada smart search
}

print("=" * 55)
print("  AI SYSTEM CLASSIFIER")
print("  Is it Narrow AI, General AI, or Super AI?")
print("=" * 55)

# TODO: Print the list of available AI systems
# Hint: use enumerate(ai_systems, 1) to number them

# TODO: Create a while loop that:
#   1. Asks the user to enter an AI system name (or 'quit')
#   2. If the name is in ai_systems, print its type, what it does, and PH context
#   3. If the name is NOT in the dictionary, print a helpful message
#      (hint: if it exists today, it's almost certainly Narrow AI!)
#   4. If user types 'quit', break out of the loop
