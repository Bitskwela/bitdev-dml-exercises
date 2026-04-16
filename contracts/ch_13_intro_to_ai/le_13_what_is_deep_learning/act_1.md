# A Deep Network From Scratch

Build a 2-layer neural network with only numpy. Trace the forward pass step-by-step to see how data transforms through layers.

---

## Prerequisites

```
pip install numpy
```

---

## Task 1: Implement Sigmoid

```python
def sigmoid(x):
    return 1 / (1 + np.exp(-x))
```

Test it on `[-5, -2, 0, 2, 5]`. See how it maps any input to (0, 1).

---

## Task 2: Build the Architecture

```python
# Layer 1: 3 inputs -> 4 hidden neurons
w1 = np.random.randn(3, 4)
b1 = np.random.randn(4)

# Layer 2: 4 hidden neurons -> 1 output
w2 = np.random.randn(4, 1)
b2 = np.random.randn(1)
```

Total parameters: 3×4 + 4 + 4×1 + 1 = 21.

---

## Task 3: Forward Pass

```python
hidden = sigmoid(X @ w1 + b1)
output = sigmoid(hidden @ w2 + b2)
```

Trace one customer through the network and print intermediate values.

---

## Task 4: Predict for 6 Customers

```python
X = np.array([
    [1.0, 0.8, 0.9],   # hungry student
    [0.1, 0.9, 0.5],   # full worker
    [0.9, 0.1, 0.7],   # broke hungry
    [0.5, 0.7, 0.2],   # tourist
    [0.7, 0.6, 1.0],   # regular
    [0.0, 0.5, 1.0],   # just ate
])
y = np.array([[1], [0], [1], [0], [1], [0]])
```

Print predictions (threshold at 0.5) and accuracy.

---

## Task 5: Experiment with Seeds

Try `np.random.seed(42)`, `7`, `123`, `0`, `999`. Same random-weighted network produces very different outputs for different seeds — demonstrating why training matters (to find GOOD weights instead of random ones).

---

## Challenge A: 3-Layer Comparison

Build 1-layer, 2-layer, and 3-layer versions. Compare parameter count and accuracy. With random weights, depth alone doesn't help — you need training.

---

## Challenge B: Train It (Advanced)

Implement backpropagation manually:

```python
def sigmoid_derivative(x):
    return x * (1 - x)

# Training loop
for epoch in range(10001):
    # Forward
    hidden = sigmoid(X @ w1 + b1)
    output = sigmoid(hidden @ w2 + b2)

    # Error
    error = y - output

    # Backprop
    d_output = error * sigmoid_derivative(output)
    error_hidden = d_output @ w2.T
    d_hidden = error_hidden * sigmoid_derivative(hidden)

    # Update
    w2 += hidden.T @ d_output * 0.5
    b2 += d_output.sum(axis=0) * 0.5
    w1 += X.T @ d_hidden * 0.5
    b1 += d_hidden.sum(axis=0) * 0.5
```

Watch accuracy climb from ~50% (random) to 100% over 10,000 epochs.

---

## What You've Learned

- Sigmoid activation in numpy
- Matrix multiplication for forward pass (`X @ W + b`)
- Layered architecture
- Why random weights give random results (training matters!)
- How backpropagation updates weights to reduce error

Next up: **Natural Language Processing** — Dan discovers how AI reads text.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the full 2-layer network, forward pass trace, seed experiments, and (optional) backpropagation training loop.

</details>
