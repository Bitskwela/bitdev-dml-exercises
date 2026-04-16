# carinderia_calculator.py
# ============================================
# CARINDERIA PROFIT CALCULATOR
# by: <Your Name>
# ============================================

# PART 1: Display header with print()
print("=" * 45)
print("  CARINDERIA PROFIT CALCULATOR")
print("=" * 45)

# PART 2: Variables and Data Types
# TODO: Create these variables with appropriate types:
#   dish_name      -> string, e.g. "Adobo"
#   cost_per_serving -> float, e.g. 35.50
#   selling_price  -> int, e.g. 60
#   servings_today -> int, e.g. 12
#   is_bestseller  -> bool, True or False


# PART 3: Type Checking with type()
# TODO: Print the type of each variable using type().__name__


# PART 4: Math Operations
# TODO: Calculate:
#   profit_per_serving = selling_price - cost_per_serving
#   total_revenue      = selling_price * servings_today
#   total_cost         = cost_per_serving * servings_today
#   total_profit       = total_revenue - total_cost
#   markup_percent     = (profit_per_serving / cost_per_serving) * 100


# PART 5: Formatted Output with f-strings
# TODO: Print the profit report using f-strings.
# Use :.2f for 2 decimal places, :.1f for 1 decimal place.
# Example:
#   print(f"   Cost per serving:    P{cost_per_serving:.2f}")


# PART 6: More Math Operators
# TODO: Demonstrate / (regular), // (floor), % (modulo), ** (exponent)
# Example: 50 // servings_today


# PART 7: Type Conversion
# TODO: Show int("60"), float("35.50"), str(60) examples


# PART 8: Interactive Input
# TODO: Ask the user for: dish_name, selling_price, cost_per_serving, servings
# Convert the numeric inputs using float() or int()
# Recalculate profit and display a feedback message:
#   profit > 500  -> "Excellent day!"
#   profit > 200  -> "Good profit!"
#   profit > 0    -> "Small profit, but still profit"
#   else          -> "You lost money today"
