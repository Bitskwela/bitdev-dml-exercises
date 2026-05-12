# ============================================
# PCA FROM SCRATCH — Lesson 17
# by: <Your Name>
# ============================================
# Project 8 carinderia features into 2D using np.linalg.svd.
# ============================================

import io
import numpy as np
import pandas as pd

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
df["is_payday_int"]    = df["is_payday"].astype(int)
df["is_friday"]        = (df["day_of_week"] == "Friday").astype(int)
df["is_saturday"]      = (df["day_of_week"] == "Saturday").astype(int)
df["is_sunday"]        = (df["day_of_week"] == "Sunday").astype(int)
df["is_rainy"]         = (df["weather"] == "rainy").astype(int)
df["is_sunny"]         = (df["weather"] == "sunny").astype(int)
df["is_lechon_kawali"] = (df["item"] == "Lechon Kawali").astype(int)
df["quantity_z"]       = (df["quantity"] - df["quantity"].mean()) / df["quantity"].std()

feature_cols = ["is_payday_int", "is_friday", "is_saturday", "is_sunday",
                "is_rainy", "is_sunny", "is_lechon_kawali", "quantity_z"]
X = df[feature_cols].to_numpy(dtype=float)

# TODO: standardize X
mean = ...
std  = ...
X_scaled = ...

# TODO: mean-center
X_centered = ...

# TODO: SVD
# U, S, Vt = np.linalg.svd(X_centered, full_matrices=False)

# TODO: project to 2D
# X_2d = X_centered @ Vt[:2].T

# TODO: print explained variance ratio

# TODO: print PC1 loadings (sorted by absolute value, top 5)
