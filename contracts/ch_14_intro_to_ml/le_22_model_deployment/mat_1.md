## Dan's Story: The Model Survives a Restart

Wednesday evening. Computer lab.

> **Dan:** Ate, how do real ML jobs avoid retraining every time?
>
> **Ate Rina:** Save the model to bytes. Reload in another script. The trained model is just weights and parameters — those serialize cleanly. In production you'd write to disk with `joblib`. In our sandbox we use `pickle.dumps` + `io.BytesIO` — same idea, no filesystem.

Dan split his work into two roles:

- **`train.py`** — load data, fit the pipeline, dump to bytes via `pickle.dumps`
- **`predict.py`** — load bytes via `pickle.loads`, take a feature row, output a prediction

The two scripts shared no code, only a `bytes` blob. He proved the round-trip: train → dump → load → predict. The reloaded model gave the same predictions as the original. *Now it's a product.*

---

## The Concept: Persistence

### Why Save Models?

A trained model is an object in memory. To use it later — tomorrow, on another machine, after a server restart — you serialize it.

### Standard Approaches

| Format | When |
|---|---|
| `pickle.dumps()` | Python objects in memory (sandbox-safe) |
| `joblib.dump()` | sklearn models, written to disk (local dev) |
| ONNX | Cross-framework, cross-language deployment |

In our sandbox we use `pickle` — works for any Python object, no filesystem needed.

### The Sandbox-Safe Pattern

```python
import pickle
from io import BytesIO

# After training a model:
serialized = pickle.dumps(model)            # bytes in memory

# Later, in another script (or even same):
restored = pickle.loads(serialized)         # back to a model object
prediction = restored.predict(X_new)
```

`pickle.dumps` produces a `bytes` object — you can email it, post it to an API, store it in a database. No disk required.

### Versioning Discipline

In production, version your model artifacts:

```
model.v1.bin
model.v2.bin
model.latest.bin (symlink to current)
```

If v2 turns out worse, roll back to v1 instantly. *Models are artifacts. Treat them like code.*

### Sklearn Version Caution

If you train with one sklearn version and load with another, you may hit warnings or errors. Pin versions in production via `requirements.txt`. (In our pure-numpy course, this isn't a concern.)

---

## Key Takeaways

- **A trained model is an object in memory** — `pickle.dumps` saves it to bytes, `pickle.loads` restores.
- **In the sandbox: `pickle` + `BytesIO`.** Locally: `joblib` to disk. Same idea, different surface.
- **The two-script pattern** (`train.py` + `predict.py`) separates training (rare) from prediction (frequent). They share only a `bytes` blob.
- **Version your models** — treat them like code.

---

## What's Next?

Every piece is now built: load, clean, engineer, split, fit, evaluate, tune, CV, pipeline, deploy. Tomorrow we combine all of it into ONE capstone script — the end-to-end ML workflow.

**Next Lesson: Real-world ML Workflow** — one auditable script, top to bottom.
