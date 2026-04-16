## Previously on Dan's AI Journey...

Dan discovered that data is the fuel of AI and analyzed his mom's carinderia sales data using Python.

---

## Background Story

It was 9 PM, and Tita Malou's carinderia was finally closed. Dan helped Ate Nene stack the plastic chairs and wipe down the tables.

"Ma, can I borrow your notebook?" Dan asked.

Tita Malou handed over the thick, grease-stained notebook she'd been using for years. Dan opened it. The pages were a chaotic masterpiece — half-cursive handwriting in blue and black ink, amounts circled or underlined, arrows pointing to corrections, doodles in the margins. One page read:

*"March 17 — Aling Rosa bought Adobo and Rice, 70. The guy from the corner (who was that?), Sinigang + Rice, 85 GCash. Mang Pedro 2 Turon + Buko Juice 50 cash. It rained in the afternoon so a lot of people bought soup."*

Dan stared at it. This was *data* — real, valuable data about the carinderia's operations. But it was a mess.

Then Dan opened his phone and pulled up Tita Malou's GCash transaction history. The contrast was stark:

| Date | Sender | Amount | Reference |
|------|--------|--------|-----------|
| 2026-03-17 | Juan D. | 85.00 | GCash Payment |
| 2026-03-17 | Maria S. | 150.00 | GCash Payment |

Clean. Neat. Rows and columns.

He also opened Tita Malou's Facebook page showing photos of the daily menu board. Useful information, but trapped inside an image.

Dan messaged Kuya JM.

> **Dan:** *"Kuya, these are all 'data' from the carinderia. But they look so different from each other."*
>
> **Kuya JM:** *"That's because they're different TYPES of data. STRUCTURED data is like a spreadsheet — rows, columns, organized. UNSTRUCTURED data is everything else — notebooks, photos, voice recordings. 80% of the world's data is UNSTRUCTURED. That's exactly why deep learning became a big deal — it can process unstructured data that traditional algorithms can't."*

Dan looked at the notebook. Fifteen years of business intelligence, locked in messy handwriting. If he could *structure* this data — turn it into a clean spreadsheet — he could analyze it. He could find patterns. He pulled the notebook closer, opened his laptop, and started typing.

It was going to be a long night.

---

## Theory & Lecture Content

### Structured Data

**Structured data** fits neatly into tables with rows and columns. Each row is a record. Each column is a field with a specific data type.

```
  ┌──────────┬──────────┬─────────┬──────────┐
  │  Date    │  Item    │  Qty    │  Revenue │
  ├──────────┼──────────┼─────────┼──────────┤
  │ 2026-03-01│ Adobo   │   12    │   600    │
  │ 2026-03-01│ Sinigang│    8    │   520    │
  └──────────┴──────────┴─────────┴──────────┘
```

**Examples:** Spreadsheets, databases, CSV files, GCash transaction logs, barangay resident records.

**Characteristics:**
- Fixed schema (every row has the same columns)
- Easy to search, filter, and sort
- Easy for computers to process

### Unstructured Data

**Unstructured data** has no fixed format. It requires AI or specialized processing to extract useful information.

**Examples:** Text (notebooks, tweets, emails), images (photos, X-rays), audio (voice recordings), video (CCTV, TikTok), social media posts.

**Characteristics:**
- No fixed schema
- Harder for computers to process directly
- Requires AI techniques (NLP, computer vision) to extract meaning
- Contains rich information but it's "locked" inside

### Semi-Structured Data

**Semi-structured data** has some organizational properties but doesn't fit neatly into a table.

**Examples:** JSON (from APIs), HTML, XML, email headers, log files.

```json
{
  "order_id": 1234,
  "customer": "Aling Rosa",
  "items": [
    {"name": "Adobo", "qty": 1, "price": 50},
    {"name": "Rice", "qty": 1, "price": 15}
  ],
  "total": 65,
  "note": "Extra sauce please"
}
```

### Why It Matters for AI

| Data Type | AI Technique | Example |
|-----------|-------------|---------|
| Structured (tables) | Traditional ML | Predict sales from weather + day |
| Text (unstructured) | NLP | Analyze customer reviews |
| Images (unstructured) | Computer Vision (CNNs) | Read menu board photos |
| Audio (unstructured) | Speech Recognition | Transcribe phone orders |
| Video (unstructured) | Video Analysis | CCTV customer counting |

**Key Insight:** Deep Learning became revolutionary because it can process *unstructured* data — images, text, audio. Since 80% of the world's data is unstructured, deep learning unlocked an enormous amount of previously unusable information.

---

## Dan's Journal

> **March 19, 2026 — Late Night at the Carinderia**
>
> Spent four hours tonight turning Ma's notebook into a spreadsheet. Four. Hours. For like, three weeks of entries.
>
> This is what data scientists call "data cleaning." And they say it's 80% of the job. I finally understand why. The actual ML part is kind of the easy part once you have clean data.
>
> The notebook had everything — but nothing was consistent. Sometimes she wrote the customer's name, sometimes not. Sometimes she wrote "cash" or "GCash," sometimes she didn't. She used abbreviations I didn't recognize. She mixed weather notes into order records. But once I got it into a CSV — rows and columns — I could suddenly SEE the data. Patterns jumped out. Payday days had 2x the entries. Sinigang dominated on rainy days. Aling Rosa is literally a daily customer.
>
> Kuya JM said "80% of world data is unstructured." That blew my mind. Every tweet, every photo, every voice message on Messenger — unstructured. The reason ChatGPT and face recognition are a big deal? They can work with unstructured data. Traditional AI couldn't.
>
> — Dan, fingers tired, data structured.

---

## Key Takeaways

1. **Structured data** fits into rows and columns (CSV, databases, spreadsheets).
2. **Unstructured data** has no fixed format (text, images, audio, video).
3. **Semi-structured data** is in between (JSON, HTML, XML).
4. **80% of the world's data is unstructured** — which is why Deep Learning is such a breakthrough.
5. **Data cleaning is 80% of a data scientist's job** — converting messy real-world data into structured formats.
6. **Different data types need different AI techniques**: ML for tables, NLP for text, CV for images.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Bistek** | bis-TEHK | Filipino beef steak — thin slices of beef marinated in soy sauce and calamansi, topped with caramelized onions. |
| **Lumpia** | LOOM-pyah | Filipino spring rolls — can be fresh or fried. The fried version (lumpiang Shanghai) is a party essential. |
| **Tortang Talong** | tohr-TAHNG tah-LOHNG | Filipino eggplant omelet — grilled eggplant coated in beaten egg and pan-fried. A carinderia staple. |

---

## What's Next?

Dan has the concepts (AI, ML, DL), the data motivation, and a real structured dataset. But to turn this data into predictions, he needs stronger coding skills. Time to learn Python properly.

**Next Lesson: Intro to Python for AI** — Dan sets up Python, writes his first real program, and learns why Python dominates AI.

**Next:** Quiz then exercises.
