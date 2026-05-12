## Dan's Story: Reading Tita Malou's Handwriting

Tuesday night. Tita Malou's *other* notebook — for everything that wasn't sales — was open in front of Dan:

```
"order 2 kare-kare + rice 240php gcash"
"expense gulay 350 palengke"
"note: aircon kailangan repair next week"
"order 3 sinigang baboy 75ea cash"
```

> **Tita Malou:** Anak, kaya pa ba? Sort these for me — orders, expenses, notes?
>
> **Dan:** Ma, this is text. The model only knows numbers.

> **Ate Rina (DM):** Bag-of-words bata. Tokenize. Count words per line. Each line becomes a row of word counts. Then your Lesson 13 logistic regression works on it.

Dan built it. 20 hand-labeled notebook lines. ~50-word vocabulary. Train logistic regression. Test accuracy: 92%.

He showed Tita Malou a live demo. She typed *"order 5 lechon kawali GCash 700php."* Output: `{"category": "order", "confidence": 0.94}`. *Tama, anak.*

---

## The Concept: Text → Numbers

### Bag-of-Words

Turn each sentence into a vector by *counting word occurrences*. Word order is lost; word counts are kept.

```
Sentence 1: "order kare-kare rice gcash"
Sentence 2: "expense gulay palengke"

Vocabulary: [order, kare-kare, rice, gcash, expense, gulay, palengke]

S1 vector: [1, 1, 1, 1, 0, 0, 0]
S2 vector: [0, 0, 0, 0, 1, 1, 1]
```

Each sentence becomes a row of integers. Now any classifier you've built works.

### Tokenization

Crude but adequate for short Filipino notebook entries:

```python
def tokenize(text):
    text = text.lower()
    for char in ":+,.;()":
        text = text.replace(char, " ")
    return [t for t in text.split() if t]
```

For longer documents in real NLP you'd use a real tokenizer (sklearn's `CountVectorizer` or spaCy).

### TF-IDF (Briefly)

Bag-of-words counts each word equally. **TF-IDF** down-weights words that appear in many documents (like "the") and up-weights rare informative words. Often gives 1-3% accuracy boost on text classification.

### Filipino-Specific Notes

- Don't remove "stopwords" — small Tagalog words (po, na, ng) often carry meaning.
- Don't worry about Filipino-English mixing — the bag-of-words handles it via the vocabulary.
- Short notebook lines work better with **bigrams** (`ngram_range=(1,2)`) — pairs of words preserve some order.

---

## Key Takeaways

- **Text → numbers via bag-of-words.** Count words per document.
- **Any classifier works on bag-of-words.** Logistic regression is the classic choice.
- **TF-IDF** improves on raw counts by weighting rare informative words higher.
- **Filipino/English mixed text is fine** — the vocabulary handles both naturally.

---

## What's Next?

Dan has a 95%-accurate notebook classifier and an 86% busy-day predictor. Both live in memory. Tomorrow he saves them to bytes via `pickle` + `BytesIO` so the model survives a restart.

**Next Lesson: Model Deployment** — save and reload models without touching the filesystem.
