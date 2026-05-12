## Dan's Story: The Notebook Margin

Tuesday morning. Slow shift. Dan was at the back table, the 15th and 30th highlighted in Tita Malou's notebook.

> **Tita Malou:** Anak, kasi ako alam ko 'yan — payday yan, rainy yan. Lagi mas malaki ang pagbenta.
>
> **Dan:** I know po, ma. The computer doesn't know yet though.
>
> **Tita Malou:** Sabihin mo na — just tell the computer. Sabi mo computers don't think — you have to put it in the data.

Dan typed three lines:

```python
df["is_payday_int"] = ((df["date"].dt.day == 15) | (df["date"].dt.day == 30)).astype(int)
df["is_rainy"]      = (df["weather"] == "rainy").astype(int)
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)
```

Refit the SAME linear regression. Test MAE dropped from 221 to 154 — a 30% reduction. No new algorithm. No tuning. Just three columns that encoded what Tita Malou had been saying.

> **Ate Rina:** Naks bata. That's the most important lesson in ML. Most gains come from features, not algorithms.

---

## The Concept: Better Inputs Beat Fancier Models

### What Feature Engineering Is

Transforming raw data into more informative columns. Examples:

- **Extracting:** `is_payday` from `date`
- **One-hot encoding:** `weather` → `is_sunny`, `is_rainy`, `is_cloudy`
- **Interaction:** `payday_rainy = is_payday × is_rainy`
- **Lag:** `revenue_lag_1 = yesterday's revenue`

Each new feature gives the model another way to encode the truth.

### The 80/20 Rule

Real practitioners spend:
- 20% on modeling (algorithm, hyperparameters)
- 80% on data (cleaning, feature engineering, label validation)

Beginners reverse this ratio. They reach for fancier algorithms when their features are raw `date` strings.

### Linear Models Can't Find Interactions

`payday × Friday` is not the same as `payday + Friday`. Linear models add features; they cannot multiply them unless you construct the interaction column yourself.

Decision trees (Lesson 14) find interactions automatically. Linear regression does not.

### Domain Knowledge Is Gold

The most powerful features come from people who understand the *problem*, not the algorithm. Tita Malou knows:

- Paydays bump revenue
- Rainy days double sinigang
- Friday is kare-kare day
- Sunday is lechon kawali day

Each of those is a candidate feature. Your job is to give the model the same information she already has.

---

## Key Takeaways

- **Better features beat fancier models, almost always.**
- **Most production gains come from features**, not algorithm switches.
- **Linear models can't find interactions** without explicit interaction columns.
- **Domain knowledge is feature gold** — turn Tita Malou's gut into model columns.

---

## What's Next?

Dan's regression is sharper. Now he wants to *classify* — busy day or not? Tomorrow: logistic regression. Sigmoid + gradient descent + binary cross-entropy in ~30 lines of numpy.

**Next Lesson: Logistic Regression** — from scratch, gradient descent, the standard classification workhorse.
