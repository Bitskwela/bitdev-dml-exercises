## Dan's Story: Luto v2, Final Form

Tuesday night. Dorm. Two days after the napkin breakfast. He had one job left: ship Luto v2.

The acceptance criteria — written in Tita Malou's voice — were simple:

> *"Anak, given tomorrow's weather forecast and whether it's payday — sabihin mo kung ano ang ihahanda ko."*

That meant: **input** = date + weather + payday flag; **output** = top 3 ulam ranked by expected revenue.

90 minutes of code, reusing everything from Lessons 6-22. By 9:30 PM the script printed:

```
Friday 2026-07-15 (payday, rainy):
  1. Sinigang     — expected P1,470
  2. Kare-Kare    — expected P1,318
  3. Adobo        — expected P990
```

He brought the laptop to the carinderia. Tita Malou read it twice and nodded. *Tama ito. Pero sometimes ubos sa Friday rainy yung lechon kawali — push mo rin yan minsan.*

He grinned. The model would never be perfectly right. But it now spoke her language.

---

## The Concept: The Project Brief

### Acceptance Criteria

- **Input:** `(date, weather, is_payday)`
- **Output:** Top 3 ulam by expected revenue
- **Constraints:**
  - Model trained on inline carinderia sample
  - Sandbox-safe (no sklearn, no disk writes)
  - Test set touched ONCE for the final accuracy number

### Architecture

Single script. Two modes (train vs forecast). One serialized model (`bytes` blob).

```
train_mode:           forecast_mode:
   load CSV              parse inputs
   clean                  load model bytes (or retrain)
   engineer features      build feature row for tomorrow
   train regressor        for each ulam: predict expected revenue
   serialize              rank top 3
   print test MAE         print recommendation
```

### Variations Welcome

Your version doesn't have to match the reference. You could:

- Use logistic regression to filter "busy day" first, then regression
- Train one regressor per ulam (7 models)
- Engineer additional features (lag features, weather × item interactions)
- Add a confidence threshold

The acceptance criteria are the contract. Everything else is taste.

---

## Key Takeaways

- **The project is a deliverable.** Tita Malou uses the output — Dan ships it.
- **One auditable script** ties together all 22 prior lessons.
- **Acceptance criteria define the contract.** How you meet them is your choice.
- **The model won't always beat Tita Malou's gut** — but it speaks her language. That's enough.

---

## Where to Go From Here

You've built linear regression, logistic regression, decision trees, random forests, K-Means, and PCA — *from scratch in numpy*. You've split data honestly, tuned hyperparameters, run cross-validation, built pipelines, and shipped a deployable model.

That's a real ML foundation. The next courses:

- **Bitskwela: Introduction to Deep Learning** — neural networks, CNNs, transformers, when DL beats ML
- **Bitskwela: Introduction to MLOps** — production pipelines, monitoring, drift detection
- **Kaggle Learn** — short focused tutorials; join a competition for hands-on practice

The Filipino dev community in 2026 needs more people who can build, not just talk about it. The problems are here. The data is being collected right now. You can build too.

---

**This is the end of Dan's ML story — but the beginning of yours.**
