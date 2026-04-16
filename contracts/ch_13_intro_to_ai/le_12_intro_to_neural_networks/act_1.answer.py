# my_first_neuron.py
# ============================================
# MY FIRST NEURON (Perceptron) — Full Solution
# by Dan Santos
# ============================================

def neuron(inputs, weights, bias):
    """A perceptron: weighted sum + bias, then step function."""
    s = sum(x * w for x, w in zip(inputs, weights)) + bias
    return 1 if s > 0 else 0


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

print("=" * 60)
print("  MY FIRST NEURON — Carinderia Customer Predictor")
print("=" * 60)
print(f"  Weights: {weights} | Bias: {bias}")
print(f"  {'Customer':<22} {'Inputs':<20} {'Sum':>6} {'Decision'}")
print("-" * 60)
for name, inputs in customers:
    s = sum(x * w for x, w in zip(inputs, weights)) + bias
    decision = "ORDER" if s > 0 else "SKIP"
    print(f"  {name:<22} {str(inputs):<20} {s:>6.2f}  {decision}")

# Task 3: Different weight configurations
print("\n" + "=" * 60)
print("  How weights change the neuron's behavior")
print("=" * 60)
configs = [
    ("Hunger-focused",   [0.6, 0.3, 0.1], -0.5),
    ("Budget-focused",   [0.2, 0.7, 0.1], -0.5),
    ("Proximity-focused",[0.2, 0.2, 0.6], -0.5),
    ("Equal weights",    [0.33, 0.33, 0.34], -0.5),
    ("Strict (high bias)", [0.6, 0.3, 0.1], -0.8),
    ("Lenient (low bias)", [0.6, 0.3, 0.1], -0.2),
]

test_customer = [0.7, 0.5, 0.4]  # decent on all three
print(f"\n  Test customer features: {test_customer}")
print(f"  {'Config':<22} {'Decision'}")
print("-" * 40)
for name, w, b in configs:
    print(f"  {name:<22} {'ORDER' if neuron(test_customer, w, b) else 'SKIP'}")

# Task 4: Two neurons composition
print("\n" + "=" * 60)
print("  Two neurons working together")
print("=" * 60)
wA, bA = [0.6, 0.3, 0.1], -0.5        # Will order?
wB, bB = [0.3, 0.6, 0.1], -0.7        # Will order PREMIUM?

print(f"  {'Customer':<22} {'Order?':<8} {'Premium?':<10} {'Recommendation'}")
print("-" * 70)
for name, inputs in customers:
    order = neuron(inputs, wA, bA)
    premium = neuron(inputs, wB, bB)
    if order and premium:
        rec = "Upsell deluxe set"
    elif order:
        rec = "Standard meal"
    else:
        rec = "Pass"
    print(f"  {name:<22} {'YES' if order else 'no':<8} {'YES' if premium else 'no':<10} {rec}")

# Challenge: Manual training
print("\n" + "=" * 60)
print("  Challenge: Manual training — find the best weights")
print("=" * 60)

training = [
    ([1.0, 0.8, 0.9], 1),
    ([0.1, 0.9, 0.5], 0),
    ([0.9, 0.1, 0.7], 1),
    ([0.5, 0.7, 0.2], 0),
    ([0.7, 0.6, 1.0], 1),
    ([0.0, 0.5, 1.0], 0),
    ([1.0, 0.0, 0.5], 1),
    ([0.5, 0.5, 0.5], 0),
    ([0.8, 0.7, 0.8], 1),
    ([0.2, 0.2, 0.3], 0),
]

candidates = [
    ([0.6, 0.3, 0.1], -0.5),
    ([0.7, 0.2, 0.1], -0.5),
    ([0.5, 0.3, 0.2], -0.4),
    ([0.6, 0.3, 0.1], -0.4),
    ([0.8, 0.2, 0.0], -0.5),
    ([0.6, 0.2, 0.2], -0.45),
]

best_acc = 0
best = None
for w, b in candidates:
    correct = sum(1 for x, y in training if neuron(x, w, b) == y)
    acc = correct / len(training) * 100
    print(f"  w={w}, b={b}: {correct}/{len(training)} ({acc:.0f}%)")
    if acc > best_acc:
        best_acc = acc
        best = (w, b)

print(f"\n  🏆 Best: w={best[0]}, b={best[1]} ({best_acc:.0f}% accuracy)")
