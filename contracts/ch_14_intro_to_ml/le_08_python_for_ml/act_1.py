# ============================================
# SMOKE TEST — Lesson 8
# by: <Your Name>
# ============================================
# Confirm the sandbox stack works: numpy + pandas + stdlib.
# Then a dummy "majority class" baseline.
# ============================================

import csv
import io
import pickle

import numpy as np
import pandas as pd

print("=" * 60)
print("  ENVIRONMENT CHECK")
print("=" * 60)
print(f"   numpy:  {np.__version__}")
print(f"   pandas: {pd.__version__}")
print(f"   pickle: stdlib (no version)")
print(f"   io:     stdlib")
print(f"   csv:    stdlib")

# Inline 30-row carinderia sample
SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-01,Tinola,13,910,Friday,False,cloudy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-03,Lechon Kawali,11,1540,Sunday,False,sunny
2025-08-05,Tinola,8,560,Tuesday,False,cloudy
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-16,Adobo,12,960,Saturday,False,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-23,Kare-Kare,10,1180,Saturday,False,sunny
2025-08-29,Bistek,13,1235,Friday,False,sunny
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-09-01,Adobo,11,825,Monday,False,rainy
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-15,Sinigang,17,1275,Monday,True,sunny
"""

df = pd.read_csv(io.StringIO(SAMPLE_CSV))
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})
df["is_busy"] = (df["revenue"] >= 1200).astype(int)

# TODO: one-hot encode day_of_week, weather, item with pd.get_dummies
# Hint: pd.concat([df, dummies], axis=1)

# TODO: print df.shape after encoding
# TODO: print class balance for is_busy


def dummy_predict_majority(y_train, y_test):
    """Always predict the most-frequent class in y_train."""
    # TODO: find the majority class
    # TODO: return an array of that class, same length as y_test
    pass


# TODO: 80/20 split (use np.random.default_rng(42) and .permutation)
# TODO: call dummy_predict_majority, compute accuracy, print it
