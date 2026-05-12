# My First Neuron

Build a perceptron that predicts whether a customer will order from Tita Malou's carinderia. Three inputs, three weights, one bias, one step function.

---

## Task 1: Code the Neuron

```python
def neuron(inputs, weights, bias):
    s = sum(x * w for x, w in zip(inputs, weights)) + bias
    return 1 if s > 0 else 0
```

---

## Task 2: Test with 8 Customers

Each customer has three features: hunger (0-1), budget (0-1), proximity (0-1).

```python
customers = [
    ("Hungry student",     [1.0, 0.8, 0.9]),
    ("Full office worker", [0.1, 0.9, 0.5]),
    ("Broke hungry",       [0.9, 0.1, 0.7]),
    ...
]
weights = [0.6, 0.3, 0.1]
bias = -0.5
```

Print the weighted sum and decision for each.

---

## Task 3: Change the Weights

Try different weight configurations and see how predictions change:
- Hunger-focused: [0.6, 0.3, 0.1]
- Budget-focused: [0.2, 0.7, 0.1]
- Proximity-focused: [0.2, 0.2, 0.6]
- Equal weights: [0.33, 0.33, 0.34]

Same customers, different weights → see how the neuron's "personality" shifts.

---

## Task 4: Two Neurons Working Together

Build a second neuron that predicts a different output (e.g., "will order PREMIUM?" with a bias that makes it harder to activate). Combine both predictions into a final recommendation:
- Both say yes → "Upsell the deluxe set"
- First yes, second no → "Standard meal"
- First no → "Pass"

---

## Challenge: Manual Training

10 customers with KNOWN correct answers (order yes/no). Try different weight sets and bias values. Which combination gets the highest accuracy?

```python
training = [
    ([1.0, 0.8, 0.9], 1),
    ([0.1, 0.9, 0.5], 0),
    # ... 8 more
]

candidates = [
    ([0.6, 0.3, 0.1], -0.5),
    ([0.7, 0.2, 0.1], -0.5),
    ([0.8, 0.2, 0.0], -0.5),
    # try more
]
```

### Bonus: Add a 4th Input (Weather)

Extend to 4 inputs: [hunger, budget, proximity, weather_is_rainy]. Find good weights.

---

## What You've Learned

- Perceptron math: inputs × weights + bias → activation
- Weights encode importance
- Bias encodes default tendency
- Changing weights changes predictions
- Why training a neural network = finding good weights

Next up: **What is Deep Learning?** — Dan stacks neurons in layers.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the complete 8-customer test, 6 weight configurations, 2-neuron composition, and manual training grid search.

</details>
