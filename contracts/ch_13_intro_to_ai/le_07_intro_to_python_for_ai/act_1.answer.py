# carinderia_calculator.py
# ============================================
# CARINDERIA PROFIT CALCULATOR — Full Solution
# by Dan Santos
# ============================================

print("=" * 45)
print("  CARINDERIA PROFIT CALCULATOR")
print("  By Dan Santos")
print("=" * 45)

# Part 2: Variables
dish_name = "Adobo"
cost_per_serving = 35.50
selling_price = 60
servings_today = 12
is_bestseller = True

# Part 3: Type checking
print(f"\n--- Variable Types ---")
print(f"   dish_name:        {type(dish_name).__name__} -> '{dish_name}'")
print(f"   cost_per_serving: {type(cost_per_serving).__name__} -> {cost_per_serving}")
print(f"   selling_price:    {type(selling_price).__name__} -> {selling_price}")
print(f"   servings_today:   {type(servings_today).__name__} -> {servings_today}")
print(f"   is_bestseller:    {type(is_bestseller).__name__} -> {is_bestseller}")

# Part 4: Math operations
profit_per_serving = selling_price - cost_per_serving
total_revenue = selling_price * servings_today
total_cost = cost_per_serving * servings_today
total_profit = total_revenue - total_cost
markup_percent = (profit_per_serving / cost_per_serving) * 100

# Part 5: Formatted output
print(f"\n--- Profit Report for {dish_name} ---")
print(f"   Cost per serving:    P{cost_per_serving:.2f}")
print(f"   Selling price:       P{selling_price:.2f}")
print(f"   Profit per serving:  P{profit_per_serving:.2f}")
print(f"   Markup:              {markup_percent:.1f}%")
print(f"   Servings sold today: {servings_today}")
print(f"   Total Revenue:       P{total_revenue:.2f}")
print(f"   Total Cost:          P{total_cost:.2f}")
print(f"   Total Profit:        P{total_profit:.2f}")
print(f"   Bestseller?          {'Yes!' if is_bestseller else 'Not yet'}")

# Part 6: More math operators
leftover = 50 % servings_today
quotient = 50 // servings_today

print(f"\n--- More Math Operators ---")
print(f"   50 / {servings_today}  = {50 / servings_today:.2f}   (regular division)")
print(f"   50 // {servings_today} = {quotient}        (floor division)")
print(f"   50 % {servings_today}  = {leftover}        (modulo — remainder)")
print(f"   2 ** 10  = {2 ** 10}     (exponent — 2 to the 10th)")

# Part 7: Type conversion
price_as_text = "60"
price_as_number = int(price_as_text)
float_from_text = float("35.50")
back_to_text = str(60)

print(f"\n--- Type Conversion ---")
print(f"   int('60')    = {price_as_number}    (string → int)")
print(f"   float('35.50') = {float_from_text} (string → float)")
print(f"   str(60)      = '{back_to_text}'    (int → string)")

# Part 8: Interactive input
print("\n--- Live Carinderia Calculator ---")
print("(Press Enter on each prompt to use defaults)")

try:
    user_dish = input("   Dish name (default: Adobo): ").strip() or "Adobo"
    user_price = input("   Selling price in pesos (default: 60): ").strip() or "60"
    user_cost = input("   Cost per serving (default: 35.50): ").strip() or "35.50"
    user_servings = input("   Servings sold (default: 12): ").strip() or "12"

    price = float(user_price)
    cost = float(user_cost)
    servings = int(user_servings)

    profit = (price - cost) * servings

    print(f"\n💰 Profit Summary for {user_dish}:")
    print(f"   Total profit today: P{profit:.2f}")

    if profit > 500:
        print("   🏆 Excellent day!")
    elif profit > 200:
        print("   👍 Good profit!")
    elif profit > 0:
        print("   🙂 Small profit, but still profit!")
    else:
        print("   ⚠️  You lost money today. Review pricing or costs.")

except (ValueError, EOFError):
    print("   (Skipped interactive section — run in a terminal to use it.)")
