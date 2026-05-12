## Previously on Dan's AI Journey...

Dan built a 2-layer neural network from scratch and watched random weights turn into trained predictions.

---

## Background Story

Dan's phone autocorrected "Where are you guys?" to "Where are you guts?" in the barkada group chat. The chat exploded with laughing emojis.

> **Mikey:** "Dan is asking about our internal organs"
> **Jasper:** "Scary. Must be a biology midterm coming up"

Dan laughed, then paused. How does autocorrect work? It's reading his text, understanding what he probably meant, and suggesting a replacement. That's language processing. That's NLP.

He messaged Kuya JM.

> **Dan:** *"Kuya, how does autocorrect know what I mean?"*
>
> **Kuya JM:** *"NLP — Natural Language Processing. The challenge: computers only understand numbers. Words are not numbers. So NLP's first job is to CONVERT words into numbers. Then you can do math on them — classify, cluster, predict."*
>
> **Kuya JM:** *"Start simple: tokenization (split text into words), stop word removal (remove 'the', 'is', 'and'), word frequency (count how often each word appears). Then sentiment analysis — classify text as positive or negative based on which words appear."*

Dan realized something. Tita Malou's carinderia has a Facebook page with customer reviews. 20 real reviews in Taglish. He could build a sentiment analyzer to show her what customers love and what to improve.

By evening, Dan had a working review analyzer. Positive words: "masarap", "sulit", "affordable", "fresh". Negative words: "matagal", "malamig", "konti". The numbers showed: 70% of reviews were positive, mostly about food quality. 30% were negative, mostly about service speed and portion size. Tita Malou looked at the screen and said: "Anak, I can read now what they really think."

---

## Theory & Lecture Content

### The Core Challenge

**Computers understand numbers. Words are not numbers.**

NLP's first job is to convert text into numeric representations. Then ML/DL can operate on them.

### Key NLP Tasks

| Task | What It Does | Example |
|------|--------------|---------|
| **Tokenization** | Split text into words/tokens | "I love adobo" → ["I", "love", "adobo"] |
| **Stop word removal** | Drop filler words | "the is and" are removed |
| **Lowercasing** | Normalize case | "ADOBO" → "adobo" |
| **Word frequency** | Count occurrences | {"adobo": 10, "delicious": 7} |
| **Sentiment analysis** | Classify positive/negative | "masarap" → positive |
| **Named entity recognition (NER)** | Find names, places | Extract "Manila" as a location |
| **Text classification** | Assign categories | Review → "food quality" or "service" |

### Bag of Words Approach

Simple but powerful: ignore word order, just count.

"Masarap ang adobo, sulit ang price" becomes:
```
{masarap: 1, ang: 2, adobo: 1, sulit: 1, price: 1}
```

You can now train a classifier on these counts.

### Simple Sentiment via Keyword Matching

```python
positive_words = {"masarap", "sulit", "fresh", "delicious", "affordable"}
negative_words = {"matagal", "malamig", "konti", "mahal", "pangit"}

def sentiment(text):
    words = text.lower().split()
    pos = sum(1 for w in words if w in positive_words)
    neg = sum(1 for w in words if w in negative_words)
    if pos > neg: return "positive"
    if neg > pos: return "negative"
    return "neutral"
```

Not as smart as modern LLMs, but understandable and 80% accurate for short reviews.

### Why NLP is Hard

- **Sarcasm**: "Oh wow, super sarap!" said bitterly
- **Slang**: "lodi", "petmalu", "werpa"
- **Mixed languages (Taglish)**: "Sobrang masarap talaga ng adobo nila"
- **Context**: "Bitter" in food vs in emotion
- **Ambiguity**: "bank" = river bank or money bank?

Modern LLMs (like ChatGPT) handle these far better than keyword matching — but they're built on massive data and hundreds of billions of parameters.

---

## Key Takeaways

1. **NLP converts text to numbers** so computers can process it.
2. **Key steps**: tokenization → lowercasing → stop word removal → counting/classification.
3. **Bag of Words** ignores order, just counts occurrences — simple but effective.
4. **Sentiment analysis** can start with keyword matching (good enough for short text).
5. **Real NLP is hard** because of sarcasm, slang, mixed languages, context ambiguity.
6. **Modern LLMs (ChatGPT, Gemini)** are deep NLP — transformers trained on billions of text examples.

---

## What's Next?

NLP handles text. What about images? That's a whole different branch — computer vision.

**Next Lesson: Computer Vision** — Dan discovers how AI "sees" pictures as numbers.

**Next:** Quiz then exercises.
