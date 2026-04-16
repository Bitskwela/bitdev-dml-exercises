## Previously on Dan's AI Journey...

Dan confronted AI bias in a loan approval dataset and built a fair model plus a reusable bias detector.

---

## Background Story

Dan and his barkada took the MRT to SM Mall of Asia for a Saturday break. As they walked in, Dan couldn't stop spotting AI:

- **Parking system**: computer vision reading license plates at the gate
- **Lazada app notifications**: collaborative filtering recommending products
- **CCTV cameras**: facial detection for crowd counts
- **Jollibee digital menu**: dynamic content based on time of day
- **Waze on the ride home**: route optimization

"Dan, can we enjoy the mall for ONE hour without you turning everything into an AI lecture?" his friend Mikey groaned.

But in Dan's head, something clicked. The hackathon was in 7 days. He needed a project. A REAL one. Not a toy.

He thought about Tita Malou. Every day, she guesses how much rice to cook. Some days she runs out by 2 PM. Other days she has leftovers that go to the dog. Food waste. Lost revenue. Stress.

> **Dan:** *"Kuya, I know my hackathon idea. AI inventory tracker for small carinderias. I'll call it 'Luto'. Takes sales data, predicts demand, suggests how much to cook."*
>
> **Kuya JM:** *"Perfect. Real problem, real user (your mom), real data available (you've been collecting it). Ship it."*

---

## Theory & Lecture Content

### AI Across Industries

| Industry | AI Use Case | Example |
|----------|-------------|---------|
| Healthcare | X-ray anomaly detection | Cancer screening |
| Finance | Fraud detection | GCash transaction monitoring |
| Agriculture | Crop disease detection | Rice leaf analysis |
| Education | Personalized learning | Khan Academy recommendations |
| Transportation | Route optimization | Grab, Waze |
| Retail | Demand forecasting | Inventory planning |
| Manufacturing | Predictive maintenance | Factory sensor analysis |
| Entertainment | Content recommendations | Netflix, YouTube |

### PH-Specific Opportunities

- **Typhoon damage assessment** — satellite + CV for rapid response
- **EDSA traffic optimization** — if MMDA had real-time ML
- **Rice crop disease detection** — phone camera + CNN for farmers
- **Sari-sari store inventory** — simple ML for micro-retailers
- **Filipino language NLP** — underserved for Filipino, Cebuano, Ilocano
- **Carinderia waste reduction** — Dan's project (Luto!)

### The AI Project Framework

Four questions for any AI project:

1. **Problem** — What real pain are you solving? (e.g., food waste)
2. **Data** — Do you have enough? Is it representative? (Mama's sales logs)
3. **Technique** — What kind of AI? (time-series forecasting, not deep learning)
4. **Impact** — Who benefits? By how much? (carinderia owner, 20% less waste)

### Build vs Buy vs Combine

| Option | When | Example |
|--------|------|---------|
| **Build** | Unique need, have data, have skills | Dan building Luto from scratch |
| **Buy** | Common problem, off-the-shelf works | Using GCash's fraud API |
| **Combine** | Use pretrained + customize | Use OpenAI API + your data |

**For hackathons:** usually Combine — pretrained models + your data + custom logic. Move fast.

### How Dan Decided on Luto

- **Problem**: Mama wastes 15% of cooked food. Worth ~P1500/week (~P6k/month).
- **Data**: 3 months of sales logs (after Dan started tracking in Lesson 5).
- **Technique**: Weighted moving average + day-of-week effect. Simple. Fast. Good enough.
- **Impact**: 50% waste reduction = P3k/month savings for one carinderia. Scale to 10 stores = P30k/month impact.

---

## Dan's Journal

> **April 3, 2026 — SM Mall of Asia**
>
> Everywhere I look: AI. Parking cameras. Lazada notifications. Waze. CCTV. Self-checkout counters.
>
> The hackathon is in a week. I finally have my idea: **Luto** — AI inventory tracker for small carinderias.
>
> Not flashy. Not chasing trends. Just solves a real problem: Mama wastes food every day because she guesses demand. With 3 months of sales data + simple predictions, I can help her cook the right amount.
>
> Built a prototype tonight. Generated 30 days of fake carinderia data. Used day-of-week averages. Predicted tomorrow's demand. Added a "low stock alert" for ingredients falling below threshold. Showed it to Mama. She said: "Anak, this is useful."
>
> That's the bar. Not "this is cool." Not "this uses neural networks." Not "this ranks first in the hackathon." The bar is: "This is useful."
>
> Jasper is building a neural network to classify bird species. Cool. But not useful to anyone he knows. Mine is useful to my mom. I'll take that.

---

## Key Takeaways

1. **AI is EVERYWHERE** in daily Filipino life — retail, transport, fintech, social media.
2. **Great AI projects solve REAL problems** for REAL users, not toy challenges.
3. **Four project questions**: Problem, Data, Technique, Impact.
4. **Build vs Buy vs Combine**: pick based on uniqueness + data + time.
5. **Simple techniques win at hackathons** — a weighted average + good UX beats a fancy model with bad UX.
6. **Filipino-specific opportunities abound** — language, crops, micro-retail, disaster response.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **SM Mall** | es-em MAHL | Massive shopping chain; weekend tradition for Filipino families. |
| **Fiesta** | fee-YES-tah | Town festival with huge community feasts. |
| **Luto** | LOO-toh | "To cook" in Filipino — name of Dan's chatbot. |

---

## What's Next?

Dan has an idea and a simple prototype. Now he needs to learn how to talk to AI APIs — specifically LLMs like ChatGPT — to turn Luto into a true conversational helper.

**Next Lesson: Prompt Engineering** — Dan learns how to write effective prompts.

**Next:** Quiz then exercises.
