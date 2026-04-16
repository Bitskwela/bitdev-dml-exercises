# deep_network.py
# ============================================
# A DEEP NETWORK FROM SCRATCH — Full Solution
# by Dan Santos
# ============================================

import numpy as np

np.random.seed(42)


def sigmoid(x):
    return 1 / (1 + np.exp(-x))


def sigmoid_derivative(y):
    return y * (1 - y)


# Dataset
X = np.array([
    [1.0, 0.8, 0.9],
    [0.1, 0.9, 0.5],
    [0.9, 0.1, 0.7],
    [0.5, 0.7, 0.2],
    [0.7, 0.6, 1.0],
    [0.0, 0.5, 1.0],
])
y = np.array([[1], [0], [1], [0], [1], [0]])

print("=" * 55)
print("  DEEP NETWORK (2-layer) — untrained forward pass")
print("=" * 55)

# Initialize random weights
w1 = np.random.randn(3, 4)
b1 = np.random.randn(4)
w2 = np.random.randn(4, 1)
b2 = np.random.randn(1)

total_params = 3 * 4 + 4 + 4 * 1 + 1
print(f"  Total parameters: {total_params}")

# Forward pass
hidden = sigmoid(X @ w1 + b1)
output = sigmoid(hidden @ w2 + b2)

pred = (output > 0.5).astype(int)
correct = int((pred == y).sum())
print(f"\n  Untrained accuracy: {correct}/{len(y)} ({correct/len(y)*100:.0f}%)")
print(f"  Outputs: {output.ravel().round(3)}")
print(f"  Labels:  {y.ravel()}")

# Trace one customer
print("\n-- Trace customer #0 through the network --")
c = X[0]
z1 = c @ w1 + b1
h = sigmoid(z1)
z2 = h @ w2 + b2
o = sigmoid(z2)
print(f"  Input:          {c}")
print(f"  Layer 1 z:      {z1.round(3)}")
print(f"  Layer 1 hidden: {h.round(3)}")
print(f"  Layer 2 z:      {z2.round(3)}")
print(f"  Output:         {o.round(3)}")
print(f"  Predicted: {int(o > 0.5)}, Actual: {y[0, 0]}")

# Experiment with seeds
print("\n-- Experiment: different random seeds --")
for seed in [42, 7, 123, 0, 999]:
    np.random.seed(seed)
    w1_ = np.random.randn(3, 4); b1_ = np.random.randn(4)
    w2_ = np.random.randn(4, 1); b2_ = np.random.randn(1)
    h_ = sigmoid(X @ w1_ + b1_)
    o_ = sigmoid(h_ @ w2_ + b2_)
    pred_ = (o_ > 0.5).astype(int)
    acc = int((pred_ == y).sum()) / len(y) * 100
    print(f"   seed={seed:<4} accuracy={acc:.0f}% (random weights!)")

# Challenge B: TRAIN with backpropagation
print("\n" + "=" * 55)
print("  CHALLENGE: Train the network with backpropagation")
print("=" * 55)

np.random.seed(42)
w1 = np.random.randn(3, 4)
b1 = np.random.randn(4)
w2 = np.random.randn(4, 1)
b2 = np.random.randn(1)

learning_rate = 0.5
epochs = 10001

for epoch in range(epochs):
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
    w2 += hidden.T @ d_output * learning_rate
    b2 += d_output.sum(axis=0) * learning_rate
    w1 += X.T @ d_hidden * learning_rate
    b1 += d_hidden.sum(axis=0) * learning_rate

    if epoch % 2000 == 0:
        loss = np.mean(np.abs(error))
        pred = (output > 0.5).astype(int)
        acc = int((pred == y).sum()) / len(y) * 100
        print(f"   epoch {epoch:5d}  loss={loss:.4f}  accuracy={acc:.0f}%")

# Final
final_pred = (output > 0.5).astype(int)
final_acc = int((final_pred == y).sum()) / len(y) * 100
print(f"\n  🏆 Final trained accuracy: {final_acc:.0f}%")
print(f"     From random {correct/len(y)*100:.0f}% to trained {final_acc:.0f}% in {epochs} epochs!")
