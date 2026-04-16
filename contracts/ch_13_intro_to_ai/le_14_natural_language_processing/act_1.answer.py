# nlp_lab.py
# ============================================
# REVIEW ANALYZER — Full Solution
# by Dan Santos
# ============================================

import string
from collections import Counter

reviews = [
    "Masarap talaga ang adobo, sulit sa presyo!",
    "Matagal naman mag-serve, pero fresh naman ang lutong.",
    "Affordable at busog kaagad. Solid!",
    "Konti lang portion, hindi sulit.",
    "Malinis ang carinderia, mabait pa ang tindera.",
    "Mahal para sa ganitong laki ng serving.",
    "Super sarap ng kare-kare! Lodi!",
    "Hindi ako nagustuhan, malamig pa ang kanin.",
    "Sulit. Sarap. Busog. Balik ulit!",
    "Matagal pero masarap naman pag-dating.",
    "Best sinigang sa Marikina! Masarap talaga!",
    "Konti at mahal. Hindi ko na babalikan.",
    "Masarap at sulit, tapos malinis pa.",
    "Walang masarap dito, pangit ng luto.",
    "Sobrang sulit! Masarap kahit mura.",
    "Ok lang, hindi naman masarap, hindi rin pangit.",
    "Masarap kare-kare, masarap bistek, lahat masarap!",
    "Matagal at konti. Disappointing.",
    "Affordable, masarap, malinis — perfect!",
    "Fresh ingredients, masarap luto, mabilis service.",
]

STOP_WORDS = {
    "the", "is", "a", "and", "to", "of", "in", "at", "for", "it",
    "ang", "ng", "sa", "na", "ay", "mga", "ko", "mo", "ka", "ba", "naman",
    "din", "rin", "lang", "pa", "pero", "o", "kaya", "talaga", "para", "kahit",
    "ganitong", "laki", "ako", "pag", "ngayon", "sobrang", "super",
}

POSITIVE = {"masarap", "sulit", "fresh", "affordable", "sarap", "busog", "malinis",
            "mabait", "mabilis", "best", "perfect", "solid", "lodi", "mura"}
NEGATIVE = {"matagal", "malamig", "konti", "mahal", "pangit", "hindi", "walang",
            "disappointing"}

INTENSIFIERS = {"sobrang", "super", "talaga"}


def tokenize(text):
    text = text.lower()
    text = text.translate(str.maketrans("", "", string.punctuation))
    return text.split()


def sentiment(text):
    words = tokenize(text)
    pos = sum(1 for w in words if w in POSITIVE)
    neg = sum(1 for w in words if w in NEGATIVE)

    # Intensifier bonus: detect "sobrang [positive]" etc.
    for i, w in enumerate(words[:-1]):
        if w in INTENSIFIERS:
            nxt = words[i + 1]
            if nxt in POSITIVE:
                pos += 1
            elif nxt in NEGATIVE:
                neg += 1

    if pos > neg:
        return "positive"
    if neg > pos:
        return "negative"
    return "neutral"


# Task 2: Word frequency across all reviews
all_words = Counter()
for review in reviews:
    all_words.update(tokenize(review))

print("=" * 55)
print("  REVIEW ANALYZER — Tita Malou's Carinderia")
print("=" * 55)
print(f"\nTotal words (with stop words): {sum(all_words.values())}")
print(f"Top 10 raw words: {all_words.most_common(10)}")

# Task 3: Remove stop words
meaningful = Counter({w: c for w, c in all_words.items() if w not in STOP_WORDS})
print(f"\nTop 10 meaningful words (no stop words):")
for word, count in meaningful.most_common(10):
    bar = "#" * count
    print(f"   {word:15} {count:>2} {bar}")

# Task 4 & 5: Sentiment analysis
labels = [sentiment(r) for r in reviews]
pos_count = labels.count("positive")
neg_count = labels.count("negative")
neu_count = labels.count("neutral")

print("\n" + "=" * 55)
print("  📊 SENTIMENT REPORT")
print("=" * 55)
print(f"  Total reviews:  {len(reviews)}")
print(f"  Positive:       {pos_count} ({pos_count/len(reviews)*100:.0f}%)")
print(f"  Negative:       {neg_count} ({neg_count/len(reviews)*100:.0f}%)")
print(f"  Neutral:        {neu_count} ({neu_count/len(reviews)*100:.0f}%)")

# Find top positive and negative keywords actually present
pos_hits = Counter()
neg_hits = Counter()
for review in reviews:
    for w in tokenize(review):
        if w in POSITIVE:
            pos_hits[w] += 1
        if w in NEGATIVE:
            neg_hits[w] += 1

print(f"\n  Top positive keywords: {pos_hits.most_common(5)}")
print(f"  Top negative keywords: {neg_hits.most_common(5)}")

# Topic categorization (Challenge B)
TOPICS = {
    "food_quality": {"sarap", "masarap", "lasa", "lutong", "luto", "fresh", "pangit"},
    "service": {"mabilis", "matagal", "tindera", "service", "mag-serve"},
    "price": {"sulit", "mahal", "presyo", "affordable", "mura"},
    "cleanliness": {"malinis", "madumi", "mabaho"},
    "portions": {"konti", "malaki", "dami", "busog", "portion"},
}

print(f"\n-- Topic Breakdown --")
for topic, kws in TOPICS.items():
    hits = sum(1 for r in reviews if any(w in kws for w in tokenize(r)))
    print(f"   {topic:15} mentioned in {hits:>2}/{len(reviews)} reviews")

print("\n  💡 Recommendation: portions and service are the main complaints.")
print("     Consider slightly larger servings and faster kitchen flow.")
