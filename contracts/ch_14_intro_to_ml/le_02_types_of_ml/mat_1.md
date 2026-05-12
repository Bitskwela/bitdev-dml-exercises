## Dan's Story: A Napkin in the Carinderia

Late Tuesday afternoon. Dan was at his usual carinderia table. Ate Rina was on Discord, audio-only, voice slightly buffering.

> **Ate Rina:** Okay bata. Three problems. Tell me which feel like the same kind of problem. (1) "Predict tomorrow's revenue." (2) "Group customers into types — barkada, lola, one-off." (3) "Make Luto learn which jokes get more replies from Tita Malou."
>
> **Dan:** Those don't sound like the same kind of problem at all.
>
> **Ate Rina:** Tama. They're three different *types* of ML.

She made him grab a napkin and draw three circles: **Supervised**, **Unsupervised**, **Reinforcement**. The map of every ML problem he'd ever see.

---

## The Concept: The Three Types

### 1. Supervised Learning — "There is a right answer in the training data."

Every training row is `(features, label)`. You have past revenues, past fraud-vs-clean transactions, past click-or-not labels. The model learns to predict the label.

Two sub-flavors:
- **Regression** — label is a *number* (revenue in pesos). Lesson 4.
- **Classification** — label is a *category* (busy/normal/slow). Lesson 5.

Most of this course (Lessons 4-15, 18-23) is supervised. It's the workhorse.

### 2. Unsupervised Learning — "No labels. Find structure anyway."

You give the computer only features and ask: *what patterns are here?* The main task is **clustering** — grouping similar examples so you can spot natural categories.

Example: 200 customers + their order histories. Without labeling who is a "barkada," ask for 3 groups. The algorithm returns them. You then *name* each cluster yourself. Lesson 16.

### 3. Reinforcement Learning — "Learn from feedback over time."

No fixed dataset. An agent takes actions, gets rewards, adjusts. Game-playing AIs, recommendation systems, robotic control. We mention it twice in this course (here and Lesson 24). The math diverges fast; it's its own field.

### Three Carinderia Examples Side-by-Side

| Problem | Type | Why |
|---|---|---|
| "Predict tomorrow's revenue" | **Supervised regression** | We have past revenue numbers as labels |
| "Group customers into barkada / lola / one-off" | **Unsupervised clustering** | No one has labeled who is what; the computer must find groups |
| "Make Luto learn which jokes get replies" | **Reinforcement learning** | No static dataset; Luto adjusts over time |

If you can place a new problem on this 3-way grid, you have done 80% of the conceptual work.

---

## Key Takeaways

- **Supervised:** features + labels. Predict the label. Most common.
- **Unsupervised:** features only. Find structure (clustering, dimensionality reduction).
- **Reinforcement:** learn from feedback over time. Specialized — not the focus of this course.
- **Regression vs classification** are two flavors of supervised: predict a number vs. predict a category.

---

## What's Next?

Now that Dan knows the three types, the next question is: *what shape does a supervised problem actually have?* What's a feature, what's a label, and what columns are forbidden to use? Tomorrow on Discord, Ate Rina walks Dan through Tita Malou's notebook column by column.

**Next Lesson: Supervised Learning** — features and labels, the leakage rule, and the convention behind capital `X` and lowercase `y`.
