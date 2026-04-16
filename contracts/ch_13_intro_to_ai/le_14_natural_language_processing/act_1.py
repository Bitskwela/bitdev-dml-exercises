# nlp_lab.py
# ============================================
# REVIEW ANALYZER (NLP LAB)
# by: <Your Name>
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
    "the", "is", "a", "and", "to", "of", "in", "at", "for", "it", "this", "that",
    "ang", "ng", "sa", "na", "ay", "mga", "ko", "mo", "ka", "ba", "naman",
    "din", "rin", "lang", "pa", "pero", "o", "kaya", "kapag",
}

POSITIVE = {"masarap", "sulit", "fresh", "affordable", "sarap", "busog", "malinis",
            "mabait", "mabilis", "best", "perfect", "solid", "lodi", "mura"}
NEGATIVE = {"matagal", "malamig", "konti", "mahal", "pangit", "hindi", "walang",
            "disappointing", "ok"}


# TODO: Task 1 — tokenize(text)


# TODO: Task 2 — word frequency across all reviews


# TODO: Task 3 — filter out stop words and re-count


# TODO: Task 4 — sentiment(text) using POSITIVE/NEGATIVE sets


# TODO: Task 5 — full report (counts, top keywords, satisfaction %)
