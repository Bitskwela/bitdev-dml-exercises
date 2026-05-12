## Dan's Story: A Yes-or-No Question

Wednesday evening.

> **Tita Malou:** Anak, bukas — maliit ba ang ihahanda kong sinigang o malaki?
>
> **Dan:** Ma, depende po sa weather forecast at payday status...
>
> **Tita Malou:** Ay, just tell me yes or no. *Big batch — yes or no.*

That wasn't regression. That was binary classification. Dan messaged Ate Rina.

> **Ate Rina:** Logistic regression. Same shape as linear — weighted sum — but squashed through a sigmoid so output is a probability in (0, 1). Train with gradient descent. ~30 lines.

He typed `def sigmoid(z): return 1 / (1 + np.exp(-z))`. He wrote a `for i in range(200):` loop. He ran it. Test accuracy: 0.79.

He showed Tita Malou tomorrow's prediction: `{"is_busy": True, "prob": 0.82}`. She nodded. *Sige, prep tayo.*

---

## The Concept: Logistic Regression

### Sigmoid

```
sigmoid(z) = 1 / (1 + exp(-z))
```

Squashes any real number into (0, 1):

| z | sigmoid(z) |
|---|---|
| -∞ | ≈ 0 |
| 0 | 0.5 |
| +∞ | ≈ 1 |

The output is the **probability of class 1**.

### The Model

```
P(y=1 | X) = sigmoid(w·X + b)
```

Compute a weighted sum (same as linear regression), then squash through sigmoid. Predict class 1 if probability > 0.5.

### Training: Gradient Descent

No closed form (sigmoid isn't linear). Instead, iterate:

1. Compute predictions: `p = sigmoid(X·w)`
2. Compute the gradient of cross-entropy loss: `∇ = (1/n) · Xᵀ · (p - y)`
3. Update weights: `w = w - learning_rate × ∇`
4. Repeat 50-200 times

That's it. The gradient formula is one line of numpy.

### Precision and Recall

For binary classification, accuracy alone is incomplete:

- **Precision** = of all rows labeled "busy," how many were actually busy? *(False positives ruin precision)*
- **Recall** = of all actually busy rows, how many did the model catch? *(False negatives ruin recall)*

Tita Malou cares more about *not running out of food* (high recall) than about *not over-prepping* (high precision). Choose the metric that matches your business cost.

---

## Key Takeaways

- **Logistic regression** = linear regression + sigmoid. Outputs a probability, predicts class 1 if probability > 0.5.
- **Gradient descent** finds the weights by minimizing cross-entropy. The gradient is one numpy line.
- **From-scratch matches sklearn** within 1% accuracy on simple problems.
- **Precision vs. recall** capture different failure modes. Pick the metric that matches the cost.

---

## What's Next?

Linear models draw straight lines between classes. But carinderia data is full of interactions — payday-AND-Friday is special, not just payday OR Friday. Decision trees capture those interactions natively.

**Next Lesson: Decision Trees** — recursive Gini splits, 50 lines of numpy. First split: `is_payday`. Of course it is.
