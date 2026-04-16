## Previously on Dan's AI Journey...

Dan built a sales predictor using the Data → Model → Output pipeline, inspired by Tita Malou's 15 years of carinderia wisdom.

---

## Background Story

The fluorescent lights in the barangay hall buzzed like tired mosquitoes. Dan had been encoding data since 3 PM — resident after resident, row after row. Name. Age. Purok. Civil status. Vaccination status. Number of dependents. It was his part-time job, three afternoons a week, paying 250 pesos per session. Not glamorous, but it helped cover his load at TIP.

He was on his 47th entry — a Lola Teresita, 72 years old, Purok 5, widowed, fully vaccinated, three dependents — when it hit him like a rogue jeepney on J.P. Rizal Avenue.

He pulled out his phone, hands slightly trembling.

> **Dan:** *"Kuya JM. I just realized something. I've been working with DATA this whole time. Like, actual data. Hundreds of rows of it."*
>
> **Kuya JM:** *"Slow down haha. What data?"*
>
> **Dan:** *"Here at the barangay! I encode resident records every week. Names, ages, addresses, vaccination status. It's a DATASET. Isn't that exactly what AI needs?"*
>
> **Kuya JM:** *"NOW you're seeing it! Yes, exactly. Data is the FUEL of AI. No data, no AI. And you've been collecting it for months. Think about it — what could you DO with that data?"*

Dan leaned back in the plastic chair. What *could* he do? If he had the ages of all residents, he could figure out the age distribution of the barangay. If he had vaccination records, he could predict who might need booster shots. If he combined it with addresses, he could figure out which puroks had the most senior citizens and might need more health services.

Then his brain made the leap.

> **Dan:** *"Kuya... what about Mama's carinderia? Think about all the data she generates every day. Sales receipts. How many orders per hour. Which dishes sell out first. Whether it's payday or not. The weather. Customer counts. Ingredient costs."*
>
> **Kuya JM:** *"Exactly! Every business generates data. Every person generates data. Every transaction, every click, every sensor reading — it's all data. The difference between a regular business and a data-driven business is whether you COLLECT it and USE it."*
>
> **Dan:** *"But how? All Mama has is her notebook where she writes orders down by hand..."*
>
> **Kuya JM:** *"That's the challenge. Most small businesses in the PH don't collect data properly. But imagine if Tita Malou tracked her sales in a spreadsheet for a year — day by day, dish by dish. You could use that data to find patterns. Which day is busiest? Which dish is most profitable? When should she increase her cooking? That's the power of data."*

Dan looked around the barangay office. Rows and rows of filing cabinets. Stacks of folders. A desktop computer with Excel open, cursor blinking on row 248. Data was everywhere. It had always been everywhere. He just hadn't known what to call it.

Tita Malou's carinderia was about to go digital.

---

## Theory & Lecture Content

### Why Data Matters

Here is a truth that every AI practitioner knows:

> **AI is only as good as its data.**

You can have the most sophisticated model in the world — a neural network with billions of parameters, running on the most powerful GPUs money can buy — and it will still produce garbage predictions if you feed it garbage data.

This is known as **GIGO: Garbage In, Garbage Out.**

### Types of Data in AI

| Type | What It Is | Example |
|------|-----------|---------|
| **Training Data** | Data used to teach the model | 1 year of carinderia sales records used to train a predictor |
| **Test Data** | Data used to check if the model learned correctly | 1 month of sales records held back to verify predictions |
| **Validation Data** | Data used to tune the model during training | A separate set used to adjust settings without cheating |

Why separate them? Imagine studying for an exam using the *actual exam questions*. You'd get a perfect score — but did you really learn? The test data is like a surprise quiz: it checks whether the model truly understood the patterns, or just memorized the answers.

### Data Quality Matters

**Good Data:**
- **Complete** — No missing values. Every row has all its columns filled.
- **Accurate** — The values are correct. 85 pesos means 85 pesos, not 850.
- **Consistent** — Same format throughout. "Adobo" is always "Adobo," not sometimes "adobo" and sometimes "Chicken Adobo."
- **Relevant** — The data actually relates to what you're trying to predict.
- **Timely** — Recent enough to still be useful. 2019 sales data might not reflect 2026 trends.

**Bad Data:**
- Missing values (no revenue recorded for March 15)
- Typos and inconsistencies ("Siniganng," "singang," "SINIGANG")
- Duplicates (same transaction recorded twice)
- Irrelevant features (customer's zodiac sign probably doesn't affect sales)

### Where to Find Data

As a Filipino student interested in AI, you have many data sources:

1. **Your own collection** — Track your own habits, expenses, grades, or Tita Malou's carinderia sales
2. **Kaggle** (kaggle.com) — The world's largest repository of free datasets
3. **Philippine Open Data** (data.gov.ph) — Government datasets about the Philippines
4. **PSA** (psa.gov.ph) — Philippine Statistics Authority data on population, economy, etc.
5. **World Bank Open Data** — International datasets including PH data
6. **UCI Machine Learning Repository** — Classic datasets used in ML education

---

## Dan's Journal

> **March 18, 2026 — Barangay Hall, then jeepney ride home**
>
> Mind = blown. Data is EVERYWHERE.
>
> At the barangay office, I've been encoding resident records for 3 months. I thought it was just a boring data entry job. But today, I realized — I've been building a DATASET. Hundreds of rows of structured information. Name, age, purok, vaccination status. If I had an ML model, I could predict which residents are most likely not yet fully vaccinated based on age and location. That's AI!
>
> Then I thought about Mama. So much data goes to waste at her carinderia every single day:
> - How many orders per dish, per day
> - How much revenue
> - What the weather was
> - Whether it was payday or not
> - What time the peak hours were
> - How much she spent on ingredients
>
> All of that is either written in her notebook in her messy handwriting, or worse, just stored in her head. She doesn't have a spreadsheet, doesn't have a system. Fifteen years of data, gone. Imagine if she'd been recording all of it — we'd have the most powerful carinderia prediction model in Marikina!
>
> Kuya JM said: "Data without collection is just... experience. It stays in one person's brain and dies when they retire." That hit hard.
>
> The lesson says: Garbage In, Garbage Out. Makes sense. If your data is bad, your AI will be bad too. It's like cooking — if your ingredients are rotten, the dish won't taste good no matter how skilled you are.
>
> Starting tomorrow, I'm going to help Mama start tracking her sales properly.

---

## Key Takeaways

1. **Data is the fuel of AI** — without good data, even the best models produce bad predictions.
2. **GIGO: Garbage In, Garbage Out** — bad data = bad predictions.
3. **Three types of data**: Training (teaches the model), Test (checks it), Validation (tunes it).
4. **Good data is complete, accurate, consistent, relevant, and timely.**
5. **Data is everywhere** — every transaction, click, and observation is data. The difference between a regular and a data-driven business is whether they collect and use it.
6. **Filipino students have access to great data sources** — Kaggle, data.gov.ph, PSA, World Bank.

---

## Filipino Culture Cards

> Learn about the Filipino terms and cultural elements featured in this lesson!

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Barangay** | bah-RAHNG-guy | The smallest administrative unit in the Philippines, like a neighborhood or village. Each has its own elected captain and community hall. |
| **Palengke** | pah-LENG-keh | A traditional wet market for fresh meat, fish, vegetables, and spices. Loud, colorful, and full of life — haggling is expected! |
| **Jeepney** | JEEP-nee | A colorfully decorated public transport vehicle originally made from repurposed American military jeeps after WWII. An iconic Philippine symbol. |
| **Merienda** | mehr-YEN-dah | Afternoon snack time around 3-4 PM. A beloved Filipino tradition — think turon, banana cue, or pan de sal with coffee. |

---

## What's Next?

Dan has discovered that data is everywhere. But when he looked at Tita Malou's handwritten notebook versus her GCash transaction history, he noticed they look *completely* different. One is messy scribbles. The other is a neat spreadsheet. Are they both "data"?

**Next Lesson: Structured vs Unstructured Data** — Dan discovers the difference between the two types and why it matters so much for AI.

**Next:** Quiz then exercises.
