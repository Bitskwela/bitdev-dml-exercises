## Previously on Dan's AI Journey...

Dan learned the difference between AI, ML, and DL — and crushed Jasper's quiz about it.

---

## Background Story

It was 5:30 PM on a Friday, and the carinderia was chaos.

Dan ducked under the tarp extension as rain hammered the corrugated roof. Inside, Tita Malou was a force of nature — barking orders at Ate Nene to wash more rice, checking the sinigang's seasoning, counting styrofoam containers. The small TV in the corner was playing the evening news, but nobody was watching. Everyone was too busy.

"Ma, how do you know there'll be a lot of customers tonight?" Dan asked, wiping down the last plastic table. He'd been thinking about AI all day — ever since Jasper challenged him to explain how algorithms actually *work* during their lunch break at TIP.

Tita Malou didn't even look up from the stove. "Anak, it's Friday today. Payday at the factories in Concepcion. Plus it's raining — when it's like this, people want hot soup. And there's a basketball league game at Kapitan's covered court, so the players will come here after the game." She tasted the sinigang broth and added more tamarind. "This isn't enough. Get two more pots ready."

Dan stared. His mom had just processed three different data points — payday schedule, weather, and local events — and produced a prediction. She did it in under five seconds. No spreadsheet, no calculator, just fifteen years of running this carinderia in Marikina.

He pulled out his phone and messaged Kuya JM on Messenger.

> **Dan:** *"Kuya, I think my mom is literally an AI model"*
>
> **Kuya JM:** *"HAHAHA what are you on about?"*
>
> **Dan:** *"Seriously! Just now, she checked if it's payday, if it's raining, and if there's a basketball game — then she predicted there'd be lots of customers and decided to cook extra sinigang. It's like... data in, process, prediction out?"*
>
> **Kuya JM:** *"Bro... that's EXACTLY how AI works. You just described the entire AI pipeline. Data goes in, a model processes it, prediction comes out. Tita Malou IS the model — she's been 'trained' on 15 years of carinderia experience! Every payday she observed, every rainy Friday, every fiesta — all of that became 'training data' for her brain."*
>
> **Kuya JM:** *"The difference with real AI? Instead of one person's brain, you use math and code. Instead of 15 years of personal experience, you feed it thousands or millions of data points. But the PIPELINE is the same: DATA in, MODEL processes, OUTPUT comes out."*
>
> **Dan:** *"So if I could collect all of Ma's 'data' — weather, day, events, sales results — and feed it to a computer... it could learn to predict like she does?"*
>
> **Kuya JM:** *"Now you're thinking like an AI engineer. That's literally what machine learning is. But for now, understand the pipeline first. That's the foundation of EVERYTHING."*

Dan looked up from his phone. Tita Malou was right — the after-game crowd was starting to arrive, wet from the rain, already scanning the menu board. She caught his eye and tossed him an apron.

"That's enough with the phone. Start serving, Anak."

Dan pocketed his phone and got to work. But his mind was already building something.

---

## Theory & Lecture Content

### The AI Pipeline

Every AI system — from Netflix recommendations to self-driving cars — follows the same fundamental pipeline:

```
  ┌──────────┐      ┌──────────┐      ┌──────────┐
  │          │      │          │      │          │
  │   DATA   │ ───> │  MODEL   │ ───> │  OUTPUT  │
  │  (Input) │      │ (Brain)  │      │(Decision)│
  │          │      │          │      │          │
  └──────────┘      └──────────┘      └──────────┘
       │                 │                  │
  Weather, day,     Rules learned       "Cook extra
  events, payday    from experience     sinigang today!"
```

### Step 1: DATA (The Input)

Data is the raw information that goes into the system. In Tita Malou's case:
- **Weather:** Is it raining, sunny, or cloudy?
- **Day of the week:** Weekday or weekend?
- **Payday:** Is it the 15th or 30th? (Philippine paydays)
- **Events:** Is there a fiesta, basketball game, or school event nearby?

In real AI, data can be anything: numbers, text, images, audio, sensor readings. The key is that it must be *relevant* to the prediction you want to make.

### Step 2: MODEL (The Brain)

The model is the part that *processes* the data and finds patterns. Tita Malou's "model" is her brain, trained on 15 years of running a carinderia. She knows from experience:
- Payday Fridays = 2x more customers
- Rainy days = people want hot soup (sinigang, nilaga)
- Basketball game nights = hungry players ordering at 8 PM
- Fiestas = cook triple the usual amount

In AI, the model is a mathematical function that has learned patterns from historical data. It could be a simple set of rules, a decision tree, or a massive neural network with billions of parameters.

### Step 3: OUTPUT (The Prediction/Decision)

The output is the model's prediction or decision:
- "Cook 3 extra pots of sinigang"
- "Prepare rice for 80 customers instead of 40"
- "Start frying lumpia at 11 AM, not 11:30"

In AI, outputs can be: classifications ("spam" or "not spam"), numbers (predicted sales = 15,000 pesos), recommendations ("you might also like this movie"), or actions ("turn the steering wheel left").

### Why This Matters

Understanding the pipeline is crucial because:
1. **Bad data = bad predictions.** If Tita Malou only looked at the weather but ignored payday, her predictions would be wrong half the time.
2. **The model needs training.** Tita Malou wasn't born knowing these patterns. She learned from 15 years of trial and error.
3. **The output is only as good as steps 1 and 2.** Garbage in, garbage out.

### Tita Malou vs. Real AI

| Aspect | Tita Malou | Real AI |
|--------|-----------|---------|
| Data | Personal observation | Thousands/millions of data points |
| Model | Brain + experience | Mathematical algorithms |
| Training | 15 years of cooking | Minutes to hours on a computer |
| Speed | Seconds (intuition) | Milliseconds |
| Scale | 1 carinderia | Millions of predictions at once |
| Weakness | Gets tired, might forget | Needs good data, can be biased |

---

## Dan's Journal

> *Dan wrote in his journal after the dinner rush:*
>
> **March 15, 2026 — Marikina**
>
> I had a huge realization today. My mom, for the past 15 years, has been doing exactly what AI does — collecting data, processing it in her brain, then making predictions. She's not just cooking. She's been running a prediction model powered by experience.
>
> Data → Model → Output. It really is that simple at its foundation. But it's so powerful.
>
> When I say "the weather is rainy + it's payday + there's a basketball game" — my mom, within 2 seconds, already knows: "Cook 3 extra pots of sinigang." That's a prediction! She's not a math genius or a fortune teller — she's experienced. And that experience is her training data.
>
> The difference between my mom and real AI? Scale. My mom can only predict for one carinderia. But if all her data from the past 15 years were recorded — every payday, every rainy day, every fiesta — we could train a computer to do the same thing. And not just for one carinderia, but for thousands.
>
> Kuya JM says the pipeline is the foundation of EVERYTHING in AI. If you understand Data → Model → Output, you already get 80% of the concept. The rest is just making the model smarter.
>
> Tomorrow, I want to figure out: where does the DATA come from? How would I even collect data from my mom's carinderia?

---

## Key Takeaways

1. **Every AI system follows the pipeline:** Data → Model → Output.
2. **Data** is the raw input — can be numbers, text, images, or sensor readings. Must be relevant to the prediction.
3. **Model** is the brain that processes data and finds patterns. Can be simple rules or a complex neural network.
4. **Output** is the model's prediction or decision — classification, number, recommendation, or action.
5. **Garbage in, garbage out**: the output is only as good as the data and model.
6. **Tita Malou has been running an AI pipeline** for 15 years — just with a human brain instead of a computer.

---

## Filipino Culture Cards

> Learn about the Filipino terms and cultural elements featured in this lesson!

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Tita** | TEE-tah | Auntie — used for older women, whether related or not. A sign of warmth and familiarity in Filipino culture. |
| **Carinderia** | kah-rin-DEH-ryah | A small, family-run eatery — the heart of Filipino street food culture. Customers point at dishes behind a glass counter ("turo-turo"). Affordable, home-cooked meals for working-class Filipinos. |
| **Ate** | AH-teh | Respectful term for an older sister or older female relative/friend. The female counterpart of Kuya. |
| **Fiesta** | fee-YES-tah | A town or barangay festival celebrating a patron saint. Families cook massive amounts of food and open their doors to everyone. |

---

## What's Next?

Dan has now grasped the fundamental pipeline of AI: **Data goes in, a Model processes it, and an Output comes out.** He even coded his first predictor based on Tita Malou's 15 years of wisdom.

But something is bugging him. The predictor works, but the "rules" are hardcoded. In real AI, the model *learns* rules from data. And for that, you need... data. Lots of it.

**Next Lesson: Data in AI** — Dan goes to his part-time job at the barangay office and realizes he's been sitting on a goldmine of data this whole time.

**Next:** Quiz then exercises.
