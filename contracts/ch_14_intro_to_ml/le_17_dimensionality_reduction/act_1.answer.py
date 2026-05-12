# ============================================
# PCA FROM SCRATCH — Full Solution
# Lesson 17 by Dan Santos
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

# Standardize
mean = X.mean(axis=0)
std  = X.std(axis=0)
std[std == 0] = 1.0   # avoid divide-by-zero on constant cols
X_scaled = (X - mean) / std

# Mean-center (already done by standardize, but explicit for clarity)
X_centered = X_scaled - X_scaled.mean(axis=0)

# SVD
U, S, Vt = np.linalg.svd(X_centered, full_matrices=False)

# Project to 2D
X_2d = X_centered @ Vt[:2].T

# Explained variance
ev = (S ** 2) / (S ** 2).sum()
print("=" * 65)
print("  PCA — FROM SCRATCH (np.linalg.svd)")
print("=" * 65)
print(f"\n   Input shape: {X.shape}")
print(f"   2D projection shape: {X_2d.shape}")
print()
print("   Explained variance ratio:")
for i, e in enumerate(ev):
    bar = "#" * int(e * 60)
    print(f"     PC{i+1}: {e:.3f}  {bar}")

print(f"\n   First 2 PCs together: {ev[:2].sum():.1%}")
print(f"   First 3 PCs together: {ev[:3].sum():.1%}")

# PC1 loadings
pc1_loadings = Vt[0]
print()
print("   PC1 loadings (sorted by absolute value):")
for name, w in sorted(zip(feature_cols, pc1_loadings), key=lambda kv: -abs(kv[1])):
    direction = "+" if w > 0 else "-"
    print(f"     {name:<20} {direction}{abs(w):.3f}")

# Show first 5 projected rows
print()
print("   First 5 rows in PC1-PC2 space:")
for i in range(5):
    pay = df["is_payday_int"].iloc[i]
    marker = " ★" if pay else "  "
    print(f"     row {i}: PC1={X_2d[i, 0]:>7.2f}  PC2={X_2d[i, 1]:>7.2f}  payday={pay}{marker}")

print()
print("-- Takeaway --")
print("   8 features compressed to 2 components.")
print("   PC1 = 'busy-payday axis' (high loadings on is_payday, quantity, is_friday).")
print("   Payday rows separate from non-payday along PC1.")
