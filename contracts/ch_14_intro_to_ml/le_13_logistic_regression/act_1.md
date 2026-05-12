# Logistic Regression From Scratch

Build a `LogisticRegressionScratch` class with sigmoid + gradient descent.

---

## Task 1: Sigmoid

Open `act_1.py`. Implement:

```python
def sigmoid(z):
    z = np.clip(z, -500, 500)         # prevent overflow
    return 1.0 / (1.0 + np.exp(-z))
```

---

## Task 2: The Class

```python
class LogisticRegressionScratch:
    def __init__(self, lr=0.1, n_iter=200):
        self.lr = lr
        self.n_iter = n_iter
        self.weights_ = None
    
    def fit(self, X, y):
        # 1. Prepend all-1s column
        # 2. Initialize weights to zero
        # 3. Loop n_iter times:
        #    p = sigmoid(X_bias @ w)
        #    gradient = (1/n) * X_bias.T @ (p - y)
        #    w -= lr * gradient
        ...
    
    def predict_proba(self, X):
        # Return probabilities
        ...
    
    def predict(self, X, threshold=0.5):
        # Return 0/1 labels
        ...
```

---

## Task 3: Fit on Carinderia

Build `is_busy` (revenue ≥ 1200) labels. Features: payday/friday/saturday/rainy flags. Train, predict on held-out test, compute accuracy, precision, recall, confusion matrix.

---

## Sample Output

```
   Intercept:     -1.124
   weight is_payday_int   +1.892
   weight is_friday       +0.421
   weight is_saturday     +0.308
   weight is_rainy        +0.187

   Test accuracy: 0.781
   Confusion: TN=12, FP=1, FN=3, TP=4
   Precision: 0.800
   Recall:    0.571
```

---

## Reflection Questions

1. The weight on `is_payday` is largest. Does that match Tita Malou's intuition?
2. Recall is lower than precision (0.57 vs 0.80). What does that mean for Tita Malou's prep decisions?
3. If she cared more about not running out of food, would she want to *lower* or *raise* the 0.5 decision threshold?

---

## What You've Learned

- Sigmoid + gradient descent = logistic regression in ~30 lines
- Cross-entropy gradient formula in one numpy line
- Precision vs. recall capture different cost trade-offs
