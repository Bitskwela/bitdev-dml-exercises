## Previously on Dan's AI Journey...

Dan trained an RL delivery agent to navigate Marikina — watching it improve from random stumbling to near-optimal pathfinding.

---

## Background Story

Dr. Reyes — a data scientist at a Manila fintech company — gave a guest lecture at UP. The topic: "When AI Goes Wrong."

She pulled up a case study. Their loan approval AI had rejected thousands of applicants from Visayas and Mindanao despite good credit history. Why?

The training data was from 2015-2020 — when the company served mostly Metro Manila customers. The model learned: "NCR address = low risk. Provincial address = high risk." Even when a Visayan applicant had higher income than an approved NCR applicant, they were rejected. Historical bias baked into the data, amplified by the model.

"We spent six months retraining with balanced data and explicit fairness constraints," Dr. Reyes said. "But the lesson is: your model inherits every bias in your training data. AI can scale unfairness faster than any human bureaucracy."

Dan sat stunned. He looked at Jasper next to him. Jasper's expression was "that's cool, let's move on to the next slide." Dan's expression was different.

That night he built a bias detector. Loan application dataset. 100 applications. He looked at approval rates by region. NCR applicants: 85% approved. Mindanao applicants at the SAME income level: 45% approved.

Wrong. Full stop.

He built a "fair" version where approval depended only on income — not region. Accuracy dropped 4%, but fairness improved dramatically.

> **Dan:** *"Kuya, the 'fair' version is 4% less accurate. Is that worth it?"*
>
> **Kuya JM:** *"Always. A 4% accuracy hit to not systematically discriminate against Mindanao? Yes. Always yes. The world has enough unfairness without AI amplifying it."*

---

## Theory & Lecture Content

### The Bias Feedback Loop

```
Biased historical data → Model learns bias → Unfair decisions
         ↑                                          ↓
         ←──  Unfair decisions become new data ──←
```

This is how small initial biases compound over time. Every decision reinforces the pattern.

### Types of Bias

| Type | What It Is | Example |
|------|-----------|---------|
| **Sampling bias** | Training data doesn't represent the population | Only Metro Manila loans in dataset |
| **Historical bias** | Past discrimination baked into labels | Old approval decisions were racist |
| **Measurement bias** | Features measured differently by group | Credit score built on urban patterns |
| **Confirmation bias** | Model reinforces developer assumptions | Developer tunes model toward expected result |
| **Label bias** | Human labelers were biased | Reviewers scored foreign names lower |

### Real-World Cases

- **Amazon hiring AI** — penalized resumes containing "women's" (like "women's chess club"). Scrapped in 2018.
- **COMPAS criminal justice** — predicted Black defendants as higher risk at nearly 2x the rate of white defendants.
- **Facial recognition** — 99% accurate on light-skinned men, ~65% on dark-skinned women.
- **Healthcare algorithm** — allocated less care to Black patients at the same severity level.

### The 5 Pillars of Responsible AI

1. **Fairness** — equal treatment across groups (race, gender, region)
2. **Transparency** — explain how decisions are made
3. **Accountability** — someone is responsible when AI fails
4. **Privacy** — protect personal data
5. **Safety** — test for failure modes before deployment

### How to Detect Bias

Compare outcomes across groups:

```python
by_region = df.groupby("region")["approved"].mean()
# Big differences = possible bias
```

Check if same-qualification applicants get different outcomes:

```python
same_income = df[df["income"].between(30000, 40000)]
by_region_fair = same_income.groupby("region")["approved"].mean()
```

If the second comparison still shows big differences, something other than qualification is driving decisions.

### The Accuracy-Fairness Tradeoff

Sometimes improving fairness reduces raw accuracy (on biased test data). That's OK — the accuracy number on biased data is misleading. True model quality requires BOTH good accuracy AND fair outcomes.

---

## Dan's Journal

> **March 31, 2026 — Classroom, after Dr. Reyes' lecture**
>
> AI isn't automatically fair. It's only as fair as its training data.
>
> I built a bias detector today on loan approval data. Same income level (P35k-45k), approval rates by region:
> - NCR: 82%
> - Luzon (outside NCR): 68%
> - Visayas: 51%
> - Mindanao: 45%
>
> Same income. Same qualifications. Different approval rates. That's not risk analysis — that's discrimination.
>
> Built a fair model that only used income. Accuracy dropped from 78% to 74%. But it approved equally across regions. Dr. Reyes would be proud.
>
> For my hackathon, I'm going to write an "AI Ethics Statement" before I build anything. Commitments:
> - Fair across regions, genders, ages
> - Transparent — explainable decisions
> - Privacy-preserving — no unnecessary data collection
> - Human-in-the-loop — final decisions reviewed by Mama, not automated
> - Failure-tested — I'll break my own system before deploying
>
> Jasper still thinks I'm overthinking. He doesn't get it. That's fine. Someone has to.

---

## Key Takeaways

1. **AI inherits bias from training data.** Garbage in = unfair out.
2. **Bias types**: sampling, historical, measurement, confirmation, label.
3. **Real systems have caused real harm** — Amazon hiring, COMPAS, facial recognition, healthcare algorithms.
4. **5 Pillars**: Fairness, Transparency, Accountability, Privacy, Safety.
5. **Detect bias by comparing outcomes across groups** with the same qualifications.
6. **Accuracy vs fairness tradeoff** — sometimes you lose a few accuracy points to be fair. Worth it.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Barangay** | bah-RAHNG-guy | Smallest admin unit in PH. |
| **GCash** | jee-CASH | Top mobile wallet in the Philippines. |
| **BGC** | bee-jee-see | Bonifacio Global City — PH fintech hub. |

---

## What's Next?

Dan has technical skills AND ethical awareness. Time to identify a real problem to solve for his hackathon.

**Next Lesson: AI Applications** — Dan brainstorms his hackathon project at SM Mall.

**Next:** Quiz then exercises.
