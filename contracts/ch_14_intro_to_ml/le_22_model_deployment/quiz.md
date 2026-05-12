# Lesson 22 Quiz: Model Deployment

---
# Quiz 1
## Scenario: The Model Survives a Restart

Dan trains a model, serializes it, reloads it. The reloaded model gives identical predictions.

**Question 1:** What does `pickle.dumps(model)` produce?
A. A string
B. A `bytes` object that represents the model — can be stored anywhere
C. A list
D. A file

**Answer:** B
**Explanation:** `pickle.dumps` returns bytes in memory. You can email them, post to an API, store in a DB.

---

**Question 2:** What does `pickle.loads(bytes)` do?
A. Saves to disk
B. Deserializes the bytes back into the original Python object
C. Hashes the bytes
D. Compresses them

**Answer:** B
**Explanation:** `pickle.loads` is the inverse — bytes back to a model object you can predict with.

---

**Question 3:** Why use `pickle` + `BytesIO` in the bitdev sandbox instead of `joblib.dump('model.pkl')`?
A. Speed
B. The sandbox has no writable filesystem; `pickle.dumps` returns bytes in memory, no disk needed
C. pickle is more accurate
D. Random preference

**Answer:** B
**Explanation:** Sandbox constraint. `joblib.dump` would fail; `pickle.dumps` works because it stays in memory.

---

**Question 4:** What's the typical TWO-SCRIPT pattern for deployment?
A. `data.py` + `viz.py`
B. `train.py` (fit + serialize, runs once) + `predict.py` (load + predict, runs every prediction)
C. `dev.py` + `prod.py`
D. There is no pattern

**Answer:** B
**Explanation:** Training is rare; prediction is frequent. They share only the serialized model — clean separation.

---

# Quiz 2
## Scenario: Production Discipline

Dan ships v1. Two weeks later, v2 (different model). What happens?

**Question 5:** Why do production ML teams VERSION their model artifacts?
A. Aesthetics
B. So you can roll back instantly if v2 turns out worse than v1 — without retraining
C. Tradition
D. Random

**Answer:** B
**Explanation:** Model artifacts are like code: bug fixes, regressions, rollbacks. Versioning enables safe deployment.

---

**Question 6:** What's the risk of training with one sklearn version and loading with another?
A. None
B. Internal data structures may differ between versions — you can get warnings or outright errors
C. Lower accuracy
D. Speed

**Answer:** B
**Explanation:** Pin versions in production. `requirements.txt` is your friend.

---

**Question 7:** What does it mean that "deployment" can be EMAILING a `bytes` blob?
A. It's a joke
B. Once a model is serialized to bytes, you can transport it any way — email, API, database. That's the whole "deployment" abstraction.
C. Emails are required
D. Random

**Answer:** B
**Explanation:** Serialization is the deployment abstraction. The bytes are portable; how you transport them is an implementation detail.

---
**Next:** Proceed to Lesson 22 exercises.
