## Previously on Dan's AI Journey...

Dan learned that all current AI is Narrow AI — specialized systems that can only do one thing. General AI (human-level intelligence) does not exist, and Super AI is pure science fiction. No robot apocalypse anytime soon. He built an AI classifier program and finally stopped panicking about robots taking over the world.

Now, a new challenge: buzzwords.

---

## Background Story

It was lunch time at the UP Diliman canteen. Dan was eating his tapsilog in peace when his classmate Jasper dropped into the seat across from him.

> **Jasper:** "Bro, yesterday was intense. I trained a machine learning model for our thesis. Just linear regression for now, but deep learning is next. I'm going to study neural networks — convolutional ones, since our project is image classification."
>
> **Dan:** *(nodding, chewing slowly)* "Ah... nice, nice."
>
> **Jasper:** "What about you, what's your approach? ML or DL?"
>
> **Dan:** "Uhh... it depends. I'm still exploring my options."

Jasper left after lunch. Dan sat there, staring at his empty plate. He did not understand a single word Jasper had said. Machine learning. Deep learning. Neural networks. Convolutional. Were these the same thing? Different things? Was one better than the other?

He pulled out his phone.

> **Dan:** Kuya, Jasper at the canteen earlier was dropping "machine learning" and "deep learning" and "neural networks." I was nodding along but honestly I didn't understand any of it. What's the difference? Isn't it all just AI?
>
> **Kuya JM:** Haha, classic Jasper. Okay, listen. Think of it like matryoshka dolls — those Russian nesting dolls that stack inside each other.
>
> **Dan:** The wooden dolls that have a doll inside? Which has another doll inside?
>
> **Kuya JM:** Exactly! AI is the BIGGEST doll — the outer shell. It covers EVERYTHING about making machines smart. This includes simple if-else rules, like your ulam recommender.
>
> **Kuya JM:** Machine Learning is a SMALLER doll that fits INSIDE the AI doll. It's a specific approach where machines LEARN from data instead of you writing all the rules by hand.
>
> **Kuya JM:** Deep Learning is the SMALLEST doll that fits INSIDE the ML doll. It's a specific type of ML that uses neural networks with many layers.
>
> **Dan:** Wait... so DL is inside ML, which is inside AI?
>
> **Kuya JM:** Yes! Think of a Filipino food analogy. All sinigang is soup, but not all soup is sinigang. All deep learning is machine learning, but not all machine learning is deep learning. All machine learning is AI, but not all AI is machine learning.
>
> **Dan:** OHHH. So my ulam recommender — that's AI, but it's not machine learning because the rules are hardcoded?
>
> **Kuya JM:** EXACTLY. You're getting it. Your ulam recommender is rule-based AI. If you trained it on data — like giving it 10,000 examples of weather + budget + mood + what people actually ordered — and let it figure out the patterns, THAT would be machine learning.
>
> **Dan:** And deep learning?
>
> **Kuya JM:** If you used neural networks with many layers to do that learning — like how your phone recognizes faces from photos — that's deep learning. DL is great for complex stuff like images, speech, and language.
>
> **Dan:** Kuya... I think I finally get it. I wish you were my professor.

Dan grinned. For the first time, the buzzwords made sense. Next time Jasper started dropping jargon at lunch, Dan would actually know what he was talking about.

---

## Theory & Lecture Content

### The Three Layers

Imagine three circles, one inside the other — or three matryoshka dolls nested together:

```
┌─────────────────────────────────────────────┐
│  ARTIFICIAL INTELLIGENCE (AI)               │
│  The biggest doll — any technique that      │
│  makes machines act "smart"                 │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │  MACHINE LEARNING (ML)                │  │
│  │  Fits inside AI — machines that       │  │
│  │  LEARN from data (no hardcoded rules) │  │
│  │                                       │  │
│  │  ┌─────────────────────────────────┐  │  │
│  │  │  DEEP LEARNING (DL)             │  │  │
│  │  │  Fits inside ML — uses neural   │  │  │
│  │  │  networks with many layers      │  │  │
│  │  └─────────────────────────────────┘  │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

### 1. Artificial Intelligence (AI)

**Definition:** The broadest field — any technique or system that enables machines to mimic human intelligence. This includes everything from simple if-else rules to the most advanced neural networks.

**Examples:**
- Your ulam recommender from Lesson 1 (rule-based AI)
- A chess program with hardcoded strategies
- A thermostat that turns on AC when temperature exceeds 30 degrees

**Filipino analogy:** AI is like saying "pagkain" (food). It covers everything — from street food to fine dining. Very broad category.

### 2. Machine Learning (ML)

**Definition:** A subset of AI where machines learn patterns from data instead of being explicitly programmed with rules. You give the system examples, and it figures out the rules on its own.

**The critical difference from rule-based AI:**

| Aspect | Rule-Based AI | Machine Learning |
|--------|--------------|-----------------|
| Who writes the rules? | Human programmer | The machine discovers them from data |
| How does it improve? | Human updates the rules | Give it more/better data |
| Scaling | Hard (too many rules to write) | Easier (just add more data) |
| Example | Your ulam recommender (if-else) | Shopee recommendations (learns from your clicks) |

**Filipino analogy:** ML is like saying "lutong Pinoy" (Filipino cooking). More specific than just "pagkain" but still a broad category.

### 3. Deep Learning (DL)

**Definition:** A subset of Machine Learning that uses artificial neural networks with multiple layers (hence "deep") to learn complex patterns.

**Examples:**
- Face unlock on your phone (image recognition)
- Voice assistants understanding speech
- ChatGPT (large language model — a type of deep learning)

**Filipino analogy:** DL is like saying "sinigang." It is a specific type of lutong Pinoy (ML), which is a type of pagkain (AI).

### The Complete Analogy

```
PAGKAIN (Food)          = AI (Artificial Intelligence)
  └── LUTONG PINOY      = ML (Machine Learning)
        └── SINIGANG    = DL (Deep Learning)
```

- All sinigang is lutong Pinoy, but not all lutong Pinoy is sinigang.
- All DL is ML, but not all ML is DL.
- All ML is AI, but not all AI is ML.

### The Comparison Table

| Feature | AI (Rule-Based) | Machine Learning | Deep Learning |
|---------|-----------------|-----------------|---------------|
| **Definition** | Machines following human-written rules | Machines learning rules from data | ML using neural networks with many layers |
| **Who writes the rules?** | Human programmer | Machine learns them | Machine learns them (with neural nets) |
| **Data needed** | None or minimal | Moderate amount | Massive amounts |
| **Computing power** | Low | Moderate | Very high (GPUs needed) |
| **Best for** | Simple, well-defined tasks | Pattern recognition in structured data | Complex tasks: images, speech, text |
| **PH Example** | Ulam recommender (if-else) | GCash fraud detection | TikTok content algorithm |

---

## Dan's Journal

> **Entry #3 — "No More Pretending"**
>
> Something kind of embarrassing happened at the canteen today. Jasper was dropping "machine learning" and "deep learning" and "neural networks" while we were eating. I was just nodding along like I understood, but honestly I had zero idea what he was talking about.
>
> But after studying today — I GET IT NOW.
>
> AI is the biggest category — any technique that makes machines "smart." This includes my ulam recommender from Lesson 1. It's just simple if-else rules, but technically it's already AI.
>
> Machine Learning is a subset — instead of me writing all the rules, the machine LEARNS the rules from data. Like if you gave it 10,000 examples of "hot weather + low budget = tortang talong," it would figure out the pattern on its own.
>
> Deep Learning is a subset of ML — it uses neural networks with multiple layers. That's what's behind face recognition, voice assistants, and ChatGPT. Complex stuff.
>
> The analogy that clicked for me: **pagkain → lutong Pinoy → sinigang**. All sinigang is lutong Pinoy, but not all lutong Pinoy is sinigang. All DL is ML, but not all ML is DL. BOOM. I totally get it.
>
> Next time Jasper drops buzzwords at the canteen, I won't be pretending anymore. I might even be the one teaching him.
>
> — Dan, finally understanding the buzzwords

---

## Key Takeaways

1. **AI is the broadest field** — any technique that makes machines perform tasks requiring human intelligence. This includes simple if-else rules all the way to complex neural networks.
2. **Machine Learning is a subset of AI** where machines learn patterns from data instead of humans writing all the rules.
3. **Deep Learning is a subset of ML** that uses neural networks with many layers. It excels at complex tasks like image recognition, speech understanding, and natural language processing.
4. **The nesting relationship: DL is inside ML, which is inside AI.** All Deep Learning is Machine Learning, but not all ML is DL.
5. **The Filipino food analogy:** AI = pagkain (food). ML = lutong Pinoy (Filipino cuisine). DL = sinigang (a specific dish).
6. **The key difference between rule-based AI and ML:** In rule-based AI, humans write the rules. In ML, the machine discovers the rules from data.

---

## Filipino Culture Cards

> Learn about the Filipino terms and cultural elements featured in this lesson!

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Sinigang** | see-nee-GANG | A sour tamarind-based soup with pork or shrimp and vegetables. The ultimate comfort food, especially on rainy days. |
| **Tapsilog** | tahp-see-LOG | A breakfast combo of tapa (cured beef), sinangag (garlic rice), and itlog (egg). One of many "-silog" combos that fuel Filipino mornings. |

---

## What's Next?

Dan now knows what AI, ML, and DL are. But a question keeps bugging him: **how does AI actually WORK?** What happens inside these systems?

That weekend, Dan visits his family home in Quezon City. While helping Nanay prepare dinner, he watches her estimate how much rice to cook.

> **Nanay:** "There are three of us, plus Tita Susan might come over, and it's hot so Papa won't eat much... maybe 4 cups should be enough."

Dan realizes something: his mom just processed multiple inputs, applied rules she learned from years of experience, and produced an output. She has been doing "AI" her entire life.

**Next Lesson: How Does AI Actually Work?** — Dan discovers that the core of AI is something his Nanay has been doing all along: observing patterns in data and using them to make predictions.

**Next:** Quiz then exercises.
