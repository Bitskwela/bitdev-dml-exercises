## Dan's Story: The Data Plan Widget

Friday afternoon. Dan was on a jeepney from Marikina to Diliman. His phone buzzed: *"Data plan: 1.2 GB remaining. Estimated to last 2 days."*

He stared. *Two days.* Where did that number come from? His phone had been watching him for months — knew his average daily usage, saw data running low at the same rhythm as usual, and projected forward. That was a prediction — not a category, a *number*. **2 days.**

> **Dan:** Ate, the data widget on my phone — is that regression?
>
> **Ate Rina:** Tama bata. Predicting a *number* from past behavior. Classic regression. Telcos do it on every phone in the country.

The EDSA stretch between Cubao and Quezon Ave is full of regressions running silently — Grab waiting time, Maya cashback estimate, Shopee delivery ETA. Every one is a model predicting a number from history.

---

## The Concept: Predicting a Number

### What Regression Is

Regression = supervised learning where the label is a continuous number.

| Examples |
|---|
| Tomorrow's carinderia revenue (₱) |
| Next month's flour expense (₱) |
| Delivery ETA in minutes |
| Number of sinigang bowls to prep |

If the label takes values like 723.45 or 1200 or 25.3 → regression. If it's a category → classification (next lesson).

### Three Baselines Every Regression Should Beat

Before any model, compute three simple baselines. Your real model has to beat them — or it's overhead.

1. **Mean baseline** — predict the average revenue every day. Constant prediction.
2. **Median baseline** — predict the median. More robust to outliers than mean.
3. **Moving-average baseline** — predict the average of the last 7 days.

These are *floors*, not models. Useful only as a comparison.

### Three Common Regression Metrics

- **MAE** (Mean Absolute Error) — average of `|predicted - actual|`. In original units.
- **MSE** — average of `(predicted - actual)²`. Punishes big errors more.
- **RMSE** = `sqrt(MSE)`. Back in original units. **Most readable metric.**

We go deeper on these in Lesson 10.

---

## Key Takeaways

- **Regression predicts a continuous number** — opposite of classification.
- **Three baselines:** mean, median, moving average. Your model must beat them.
- **MAE in original units is the most readable metric.** "Off by ₱220" speaks plainly.
- **Context beats math.** A "rainy payday Friday" guess will beat any blind average. Feature engineering matters more than algorithm choice.

---

## What's Next?

Dan now has the regression mindset. Sunday morning, Tita Malou hands him 20 notebook pages and a sharpie: *"Anak, label these — busy, normal, slow."* He realizes labels aren't numbers anymore. They're categories.

**Next Lesson: Classification** — Dan hand-labels 20 days and builds a confusion matrix.
