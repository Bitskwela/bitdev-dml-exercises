# ============================================
# CARINDERIA SALES PREDICTOR
# by: <Your Name>
# ============================================
# Tita Malou's 15 years of wisdom, in code!
# Data -> Model -> Output pipeline
# ============================================

print("=" * 50)
print("  CARINDERIA SALES PREDICTOR")
print("  Tita Malou's 15 years of wisdom, in code!")
print("=" * 50)

# ============================================
# STEP 1: DATA (Collecting Input)
# ============================================
# In real AI, data comes from databases, sensors,
# APIs, files. Here, we collect it from the user.

print("\n--- STEP 1: Collecting Data ---")

# TODO: Ask the user for these 4 inputs:
#   - weather (sunny/rainy/cloudy)
#   - is_payday (yes/no) — convert to boolean
#   - day (monday-sunday)
#   - has_event (yes/no) — convert to boolean
# Hint: use input().lower().strip() to clean input


# ============================================
# STEP 2: MODEL (Processing -- The "Brain")
# ============================================
# Our model is simple: a scoring system.
# Real AI learns these rules from data.

print("\n--- STEP 2: Processing with our model ---")

score = 0  # We'll score how "busy" the day will be

# TODO: Implement the scoring rules:
#   - Payday: +3 points
#   - Weekend (saturday/sunday): +2 points
#   - Friday: +1 point
#   - Rainy or sunny weather: +1 point
#   - Has nearby event: +3 points
# For each rule that applies, print the points earned


# ============================================
# STEP 3: OUTPUT (Prediction)
# ============================================
# Translate the score into a prediction.

print("\n--- STEP 3: Prediction Output ---")
print(f"   Total Score: {score}/9")

# TODO: Print the prediction based on score:
#   score >= 6: "VERY HIGH SALES" + cooking advice
#   score >= 4: "HIGH SALES" + cooking advice
#   score >= 2: "NORMAL SALES" + cooking advice
#   else: "LOW SALES" + cooking advice


# ============================================
# SUMMARY: The AI Pipeline
# ============================================
print("\n" + "=" * 50)
print("  THE AI PIPELINE IN ACTION:")
print("  DATA -> MODEL -> OUTPUT")
print("=" * 50)
print("\n  Remember: Real AI uses LEARNED rules from data,")
print("  not hardcoded ones like ours.")
print("  But the pipeline is the same!")
