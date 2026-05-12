# ============================================
# INTRO TO NLP IN ML — Lesson 21
# by: <Your Name>
# ============================================
# Bag-of-words on Tita Malou's notebook lines.
# ============================================

import numpy as np
from collections import Counter


def tokenize(text):
    # TODO: lowercase, replace punctuation with spaces, split
    pass


# 20 labeled lines
data = [
    ("order 2 kare-kare + rice 240php gcash", "order"),
    ("order 3 sinigang baboy 75ea cash", "order"),
    ("order halo-halo 4 pcs 240 group", "order"),
    ("order 1 lechon kawali rice 140", "order"),
    ("order tinola rice 70php gcash", "order"),
    ("order 5 adobo rice 350 takeout", "order"),
    ("order 2 bistek rice 200php cash", "order"),
    ("order pinakbet rice 75 walk in", "order"),
    ("expense gulay 350 palengke", "expense"),
    ("expense tubig 12gallons sentro 240", "expense"),
    ("expense bigas 25kilo 1250 supplier", "expense"),
    ("expense baboy 5kilo 1100 palengke", "expense"),
    ("expense lpg 1 tank 950", "expense"),
    ("expense kape 250 grams 180", "expense"),
    ("expense coke pcs 12 240 sari sari", "expense"),
    ("note: aircon repair next week", "note"),
    ("note: mang dario saturday closed", "note"),
    ("note: order more sinigang ingredients monday", "note"),
    ("note: ate rosa birthday next monday handa", "note"),
    ("note: try new menu item palabok", "note"),
]

texts = [d[0] for d in data]
labels = [d[1] for d in data]

# TODO: build vocabulary (sorted unique tokens)
# vocab = ...
# vocab_to_idx = {tok: i for i, tok in enumerate(vocab)}

# TODO: build X matrix (rows = sentences, cols = words)
# TODO: build y vector (label index)
label_to_idx = {"order": 0, "expense": 1, "note": 2}

# TODO: train + predict (simplest: a 1-vs-rest logistic regression
#       or a simple word-presence classifier)
print("Dataset:", len(texts), "labeled lines")
print("Labels:", set(labels))
