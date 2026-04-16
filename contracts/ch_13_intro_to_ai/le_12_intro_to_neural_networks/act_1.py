# my_first_neuron.py
# ============================================
# MY FIRST NEURON (Perceptron)
# by: <Your Name>
# ============================================

# TODO: Task 1 — Define the neuron function
# def neuron(inputs, weights, bias):
#     compute weighted sum + bias, return 1 if > 0 else 0


customers = [
    ("Hungry student",      [1.0, 0.8, 0.9]),
    ("Full office worker",  [0.1, 0.9, 0.5]),
    ("Broke hungry",        [0.9, 0.1, 0.7]),
    ("Tourist passing by",  [0.5, 0.7, 0.2]),
    ("Regular customer",    [0.7, 0.6, 1.0]),
    ("Just ate, walking",   [0.0, 0.5, 1.0]),
    ("Starving no money",   [1.0, 0.0, 0.5]),
    ("Average everything",  [0.5, 0.5, 0.5]),
]

weights = [0.6, 0.3, 0.1]  # hunger, budget, proximity
bias = -0.5

print("=" * 55)
print("  MY FIRST NEURON — Carinderia Customer Predictor")
print("=" * 55)
print(f"  Weights: {weights} | Bias: {bias}")
print()

# TODO: Task 2 — Loop through customers, compute weighted sum, print decision


# TODO: Task 3 — Try different weight configurations
# weight_configs = [
#     ("Hunger-focused", [0.6, 0.3, 0.1], -0.5),
#     ("Budget-focused", [0.2, 0.7, 0.1], -0.5),
#     ...
# ]


# TODO: Task 4 — Two neurons composition
# Neuron A: will order?  weights = [0.6, 0.3, 0.1], bias = -0.5
# Neuron B: will order PREMIUM? weights = [0.3, 0.6, 0.1], bias = -0.7
# Combine their outputs into a final recommendation.
