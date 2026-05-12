# Round-trip a Model via pickle + BytesIO

Demonstrate the train → serialize → load → predict pattern in one script (since the sandbox shares state across cells).

---

## Task 1: Train a Tiny Model

Use logistic regression from Lesson 13 on the carinderia busy/not-busy classification. Train on a small subset.

---

## Task 2: Serialize

```python
import pickle
serialized = pickle.dumps(model)
print(f"Model serialized to {len(serialized)} bytes")
```

---

## Task 3: Reload + Predict

```python
restored = pickle.loads(serialized)
prediction = restored.predict(X_new)
```

Compare predictions from `model` and `restored`. They must match exactly.

---

## Sample Output

```
   Trained model: LogReg
   Serialized size: 1247 bytes

   Original prediction:  [1 0 1]
   Reloaded prediction:  [1 0 1]
   Match: True

   First reloaded prediction probability: 0.913
```

---

## Reflection Questions

1. Why use `pickle.dumps` instead of `joblib.dump` in this sandbox?
2. The `bytes` object can be emailed or posted to an API. Why is that the same idea as "deployment"?
3. What's the role of versioning in real production ML?

---

## What You've Learned

- `pickle.dumps` / `pickle.loads` for sandbox-safe serialization
- The two-role pattern: train (rare) vs predict (frequent)
- Why production teams version their model artifacts
