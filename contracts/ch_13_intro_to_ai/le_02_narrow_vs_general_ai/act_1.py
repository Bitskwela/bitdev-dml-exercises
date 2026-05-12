# ============================================
# AI SYSTEM CLASSIFIER
# by: <Your Name>
# ============================================
# Classify real AI systems as Narrow, General,
# or Super AI. Spoiler: they're ALL Narrow AI
# because that's the only kind that exists!
# ============================================

# Build a dictionary called `ai_systems`.
# Each key is the system name (lowercase).
# Each value is another dictionary with three keys:
#   "type": "Narrow AI"
#   "what_it_does": one short sentence
#   "philippine_context": where you encounter it in the Philippines
#
# The dictionary below shows a four-step scaffolding gradient.
# You will finish it as you work through the activity.

ai_systems = {
    # (1) Worked example — fully filled in for you. Use this as your template.
    "grab": {
        "type": "Narrow AI",
        "what_it_does": "Optimizes routes and matches riders to drivers",
        "philippine_context": "Used by millions of Filipinos daily for transportation"
    },

    # (2) Partial skeleton — the keys are here, you write the values.
    "gcash fraud detection": {
        "type": "Narrow AI",
        "what_it_does": "",  # TODO: describe what it does in one sentence
        "philippine_context": "",  # TODO: where Filipinos encounter it
    },

    # (3) Partial skeleton — same as above, second pass.
    "shopee recommendations": {
        "type": "",  # TODO: which AI type? (hint: all real-world AI is Narrow)
        "what_it_does": "",  # TODO
        "philippine_context": "",  # TODO
    },

    # (4) Empty placeholders — you write the WHOLE entry (keys + values).
    "siri": {},          # TODO: fill in type, what_it_does, philippine_context
    "face unlock": {},   # TODO: fill in all three keys

    # (5) Open slots — add at least FIVE more AI systems below.
    #     Ideas: spam filter, chatgpt, google translate, waze,
    #            youtube recommendations, tiktok algorithm, lazada smart search,
    #            spotify discover weekly, maya fraud detection, canva magic design
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
