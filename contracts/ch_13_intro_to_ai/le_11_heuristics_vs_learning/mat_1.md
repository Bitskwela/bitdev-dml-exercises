## Previously on Dan's AI Journey...

Dan implemented sorting, searching, and combo-finding algorithms — demystifying the word "algorithm" in the process.

---

## Background Story

Dan was riding the jeepney home to Marikina, wedged between a man with two chickens in a plastic bag and a woman scrolling TikTok at full volume. Mang Tonyo — 40 years old, been a jeepney driver for 15 — swerved down a side street to avoid EDSA traffic.

Dan checked Waze. It was telling him exactly the same shortcut, recalculated in real-time based on data from thousands of drivers.

Mang Tonyo had no Waze. He just *knew*.

Dan texted Kuya JM.

> **Dan:** *"Kuya, interesting thing. Mang Tonyo knows traffic shortcuts from 15 years of driving. Waze knows them from millions of GPS pings. They both arrive at the same answer. But one uses experience, the other uses data. Which is better?"*
>
> **Kuya JM:** *"BOTH. Depends on context. Mang Tonyo uses HEURISTICS — rules of thumb from experience. Waze uses LEARNING from data. Heuristics are fast but don't improve unless the person learns more. Learning systems improve every day as data grows."*
>
> **Kuya JM:** *"Tita Malou's dish recommendations — also heuristics. 'Rainy day = sinigang.' But what if we fed all her sales data into a program? The program might discover patterns she never noticed — like 'rainy Fridays = sinigang dominates' but 'rainy Mondays = lugaw wins.'"*

That gave Dan an idea. He'd build TWO recommenders for Tita Malou:
1. **Heuristic recommender** — hardcoded from her 20 years of experience
2. **Learning recommender** — learns from 200 days of sales data

Then race them against each other.

That night, the data-driven system discovered that sinigang sells BEST on rainy FRIDAYS specifically. Tita Malou never noticed that pattern. Dan's jaw dropped.

---

## Theory & Lecture Content

### Heuristics

**Heuristics** are rules of thumb — mental shortcuts built from experience or common sense. Fast, often good enough, but don't improve without a human updating them.

```python
def heuristic(weather, day):
    if weather == "Rainy": return "Sinigang"
    if day == "Friday":    return "Kare-Kare"
    return "Adobo"
```

- Written by humans
- Deploy instantly (no training)
- Transparent: easy to explain why
- Don't improve over time

### Learning Systems

**Learning systems** discover rules from data. Give them thousands of examples and they figure out the patterns.

```python
def learning_recommender(model, weather, day):
    key = (weather, day)
    return model[key]  # "What sold best on this day+weather combo?"
```

- Rules come from data (not humans)
- Improve with more data
- Can find patterns humans miss
- Often less transparent

### The Comparison

| Aspect | Heuristics | Learning |
|--------|-----------|----------|
| Rules from | Human expertise | Patterns in data |
| Needs data? | No | Yes, lots |
| Improves? | Only if human updates | With more data |
| Speed to deploy | Instant | Slow (training) |
| Transparency | High | Often low |
| Accuracy | Limited by human knowledge | Can exceed experts |

### When to Use Each

- **Heuristics**: simple problems, no data available, need explainability, MVPs
- **Learning**: complex problems, lots of data, accuracy matters, patterns are subtle

**Best practice: start with heuristics, upgrade to learning once you have data.**

### The Evolution of AI

Early AI (1960s-80s) was 99% heuristics — expert systems, rule engines. Modern AI (2010s+) is dominated by learning — neural networks discover their own rules from massive data.

---

## Dan's Journal

> **March 24, 2026 — Jeepney then dorm**
>
> Huge insight today. Built two recommenders for Mama's carinderia:
>
> 1. Heuristic one: Mama's 20 years of rules in if-else. Deployed instantly.
> 2. Data-driven one: fed 200 days of simulated sales data. It LEARNED the patterns.
>
> On the test set, the data-driven one was 8% more accurate. More importantly, it found patterns Mama didn't know about — like Sinigang dominating on rainy Fridays specifically (not all rainy days). Mama was amazed.
>
> The Waze vs Mang Tonyo thing clicked. Both get the job done. Mang Tonyo is a specialist in Marikina — he'd beat Waze in our barangay. But Waze scales to all of Metro Manila because it learns from millions of drivers.
>
> Real ML in practice: start with heuristics when you have no data, upgrade to learning when data arrives.

---

## Key Takeaways

1. **Heuristics** are rule-of-thumb rules written by humans. Fast, transparent, don't improve.
2. **Learning systems** discover rules from data. Improve with more data, can find subtle patterns.
3. **Different tools for different jobs**: heuristics for simple problems / no data; learning for complex problems with data.
4. **Best practice**: start with heuristics (MVP), upgrade to learning once you have data.
5. **Historical evolution**: early AI = heuristics. Modern AI = learning. The shift = explosion of data + compute.
6. **Human experts can be beaten** by learning systems — but humans are always needed to collect data, define the problem, and validate results.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Jeepney** | JEEP-nee | Colorfully decorated public transport; iconic Philippine symbol. |
| **EDSA** | ed-SAH | Main highway, notorious for traffic; site of 1986 People Power Revolution. |
| **Fiesta** | fee-YES-tah | Town festival celebrating patron saint; massive community cooking. |

---

## What's Next?

Learning from data sounds powerful. But counting frequencies is still simple learning. Real AI does something more sophisticated — it uses neural networks.

**Next Lesson: Intro to Neural Networks** — Dan draws a neuron on a napkin and builds his first perceptron.

**Next:** Quiz then exercises.
