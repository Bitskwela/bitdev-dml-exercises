# ============================================
# INTRO TO NLP IN ML — Full Solution
# Lesson 21 by Dan Santos
# ============================================

import numpy as np
from collections import Counter


def tokenize(text):
    text = text.lower()
    for ch in ":+,.;()":
        text = text.replace(ch, " ")
    return [t for t in text.split() if t]


data = [
    ("order 2 kare-kare + rice 240php gcash", "order"),
    ("order 3 sinigang baboy 75ea cash", "order"),
    ("order halo-halo 4 pcs 240 group", "order"),
    ("order 1 lechon kawali rice 140", "order"),
    ("order tinola rice 70php gcash", "order"),
    ("order 5 adobo rice 350 takeout", "order"),
    ("order 2 bistek rice 200php cash", "order"),
    ("order pinakbet rice 75 walk in", "order"),
    ("expense gulay 350 palengke", "expense"),
    ("expense tubig 12gallons sentro 240", "expense"),
    ("expense bigas 25kilo 1250 supplier", "expense"),
    ("expense baboy 5kilo 1100 palengke", "expense"),
    ("expense lpg 1 tank 950", "expense"),
    ("expense kape 250 grams 180", "expense"),
    ("expense coke pcs 12 240 sari sari", "expense"),
    ("note: aircon repair next week", "note"),
    ("note: mang dario saturday closed", "note"),
    ("note: order more sinigang ingredients monday", "note"),
    ("note: ate rosa birthday next monday handa", "note"),
    ("note: try new menu item palabok", "note"),
]

texts = [d[0] for d in data]
labels = [d[1] for d in data]
label_to_idx = {"order": 0, "expense": 1, "note": 2}
idx_to_label = {v: k for k, v in label_to_idx.items()}

# Build vocabulary
vocab = sorted({tok for text in texts for tok in tokenize(text)})
vocab_to_idx = {tok: i for i, tok in enumerate(vocab)}

def vectorize(text):
    vec = np.zeros(len(vocab), dtype=int)
    for tok in tokenize(text):
        if tok in vocab_to_idx:
            vec[vocab_to_idx[tok]] += 1
    return vec

X = np.vstack([vectorize(t) for t in texts])
y = np.array([label_to_idx[l] for l in labels])

print("=" * 65)
print("  BAG OF WORDS NLP")
print("=" * 65)
print(f"   Vocabulary size: {len(vocab)}")
print(f"   X shape: {X.shape}")
print(f"   Class distribution: {dict(Counter(labels))}")

# Simple multi-class logistic regression (one-vs-rest)
def sigmoid(z):
    return 1 / (1 + np.exp(-np.clip(z, -500, 500)))

def fit_binary(X, y, n_iter=500, lr=0.2):
    """One-vs-rest binary logistic regression."""
    n, p = X.shape
    Xb = np.hstack([np.ones((n, 1)), X.astype(float)])
    w = np.zeros(p + 1)
    for _ in range(n_iter):
        z = np.clip(Xb @ w, -500, 500)
        ph = sigmoid(z)
        w -= lr * (Xb.T @ (ph - y)) / n
    return w

def predict_proba(X, w):
    Xb = np.hstack([np.ones((len(X), 1)), X.astype(float)])
    return sigmoid(Xb @ w)

# Train one classifier per class (one-vs-rest)
classifiers = {}
for cls in range(3):
    y_binary = (y == cls).astype(float)
    classifiers[cls] = fit_binary(X, y_binary)

# Predict by picking highest-probability class
def predict_class(X):
    probas = np.column_stack([predict_proba(X, w) for w in classifiers.values()])
    return probas.argmax(axis=1), probas

train_preds, _ = predict_class(X)
train_acc = float((train_preds == y).mean())
print(f"   Training accuracy: {train_acc:.3f}")

# Most influential words per class
print()
print("-- Top words per class --")
for cls_idx, cls_name in idx_to_label.items():
    w = classifiers[cls_idx][1:]  # skip intercept
    top = sorted(zip(vocab, w), key=lambda kv: -kv[1])[:6]
    print(f"   {cls_name:<10}: {', '.join(t for t, _ in top)}")

# Live predictions on unseen lines
print()
print("=" * 65)
print("  LIVE PREDICTIONS")
print("=" * 65)
new_lines = [
    "order 5 lechon kawali GCash 700php",
    "expense kape 200g 175 puregold",
    "note: tindahan ni mang totoy may sale ng bigas next week",
    "order 3 turon 30",
    "expense electric bill 1200 meralco",
]
for line in new_lines:
    X_new = np.vstack([vectorize(line)])
    pred, probas = predict_class(X_new)
    p_idx = int(pred[0])
    conf = float(probas[0, p_idx])
    print(f"   '{line}'")
    print(f"     -> {idx_to_label[p_idx]} (conf {conf:.2f})")
    print()

print("-- Takeaway --")
print("   Filipino/English text → numbers → classifier.")
print("   Bag-of-words is the entry door to NLP.")
print("   Same logistic regression you built in Lesson 13.")
