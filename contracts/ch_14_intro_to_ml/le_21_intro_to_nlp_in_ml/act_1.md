# Classify 20 Notebook Lines

Build a bag-of-words classifier on 20 labeled Tagalog/English notebook entries.

---

## Task 1: Tokenize

```python
def tokenize(text):
    text = text.lower()
    for ch in ":+,.;()":
        text = text.replace(ch, " ")
    return [t for t in text.split() if t]
```

---

## Task 2: Build Vocabulary + Encode

For all 20 labeled sentences:

1. Tokenize → collect all unique words → vocabulary (sorted)
2. For each sentence, build a count vector: `vec[i] = count of word i in sentence`

```python
def vectorize(text, vocab_to_idx):
    vec = np.zeros(len(vocab_to_idx), dtype=int)
    for tok in tokenize(text):
        if tok in vocab_to_idx:
            vec[vocab_to_idx[tok]] += 1
    return vec
```

---

## Task 3: Train Logistic Regression

Convert string labels (`"order"`, `"expense"`, `"note"`) to integers (0, 1, 2). Fit your Lesson 13 logistic regression — but extended to 3 classes using **one-vs-rest**: train one binary classifier per class, predict the highest-probability class.

(Or for simplicity: use 3-fold CV accuracy as the headline.)

---

## Sample Output

```
   Vocabulary size: 84
   3-fold CV accuracy: 0.900

   Live predictions:
     'order 5 lechon kawali GCash 700php' -> order (conf 0.94)
     'expense kape 200g 175 puregold'    -> expense (conf 0.89)
     'note: try new menu palabok'        -> note (conf 0.81)
```

---

## Reflection Questions

1. Bag-of-words LOSES word order. Why does "order 3 sinigang" still classify correctly even though we don't know "order" came before "sinigang"?
2. Why does mixing Tagalog and English in the same sentence NOT confuse the classifier?
3. What would happen if you added stop-word removal that excluded common Tagalog words like "po", "na", "ng"?

---

## What You've Learned

- Bag-of-words: text → integer vectors
- Tokenization for Filipino mixed-language text
- Multi-class classification via one-vs-rest
