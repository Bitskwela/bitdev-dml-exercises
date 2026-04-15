# ============================================
# ULAM RECOMMENDER v2.0 - Enhanced Edition
# by Dan Santos
# ============================================
# Full solution: 6 inputs, time/occasion/group-size
# aware recommendations, and a final reflection on
# why rule-based AI does not scale.
# ============================================

print("=" * 45)
print("  ULAM RECOMMENDER v2.0 by Dan Santos")
print("=" * 45)

# Expanded data collection
weather = input("\nHow's the weather? (hot/rainy/cold): ").lower()
budget = input("What's your budget? (high/medium/low): ").lower()
mood = input("What's your mood? (happy/tired/stressed): ").lower()
people = input("How many are eating? (solo/family/barkada): ").lower()
time_of_day = input("What time is it? (morning/noon/merienda/evening): ").lower()
occasion = input("Any occasion? (birthday/payday/regular/exam-week): ").lower()

print("\n🍽️ Recommended Ulam for you:")

# Time-based recommendations
if time_of_day == "morning":
    if budget == "low":
        print("➡️ Sinangag + Itlog + Tuyo (Silog!) — classic Pinoy breakfast!")
    else:
        print("➡️ Tapsilog — the ultimate Filipino breakfast combo!")

elif time_of_day == "merienda":
    if weather == "rainy":
        print("➡️ Lugaw and Tokwa't Baboy — perfect merienda for a rainy day!")
    else:
        print("➡️ Banana Cue and Mais — classic street food merienda!")

# Occasion-based recommendations
elif occasion == "birthday":
    if people == "barkada":
        print("➡️ Lechon Kawali + Pancit + Lumpia — birthday party combo!")
    else:
        print("➡️ Spaghetti Filipino-style + Chicken Joy — birthday staple!")

elif occasion == "exam-week":
    print("➡️ Lucky Me Pancit Canton + Egg — every student's study fuel!")

elif occasion == "payday":
    print("➡️ Samgyupsal — every Pinoy's payday tradition!")

# Group-size-based recommendations
elif people == "barkada" and budget == "low":
    print("➡️ Street BBQ — isaw, betamax — barkada bonding!")

elif people == "family":
    if weather == "rainy":
        print("➡️ Sinigang na Hipon — family favorite on a rainy day!")
    else:
        print("➡️ Kare-Kare — a hearty home-cooked family dish!")

# Original weather/mood/budget recommendations
elif weather == "hot" and budget == "high":
    print("➡️ Halo-Halo + Kare-Kare — cool down and treat yourself!")
elif weather == "rainy" and mood == "stressed":
    print("➡️ Sinigang na Baboy — comfort food for a rainy day!")
elif weather == "cold":
    print("➡️ Bulalo — perfect for cold weather!")
elif mood == "tired":
    print("➡️ Arroz Caldo — warm and comforting!")
elif mood == "happy":
    print("➡️ Crispy Pata — celebration food!")
elif budget == "low":
    print("➡️ Tortang Talong + Rice — delicious and budget-friendly!")
else:
    print("➡️ Adobo — the classic! You can never go wrong.")

print("\n💡 Notice how more inputs = smarter recommendations?")
print("   Real AI systems consider THOUSANDS of factors!")
print("   That's why they need Machine Learning — too many rules to write by hand.")
