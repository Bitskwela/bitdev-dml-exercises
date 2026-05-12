# ============================================
# LINEAR REGRESSION FROM SCRATCH — Lesson 9
# by: <Your Name>
# ============================================
# Implement closed-form linear regression via the normal equation.
# ============================================

import io
import numpy as np
import pandas as pd


class LinearRegressionScratch:
    """Closed-form linear regression via the normal equation."""

    def __init__(self):
        self.weights_ = None
        self.intercept_ = None
        self.coef_ = None

    def fit(self, X, y):
        # TODO: prepend a column of 1s to X for the intercept
        X_bias = ...

        # TODO: solve (X^T X) w = X^T y  with np.linalg.solve
        self.weights_ = ...

        self.intercept_ = self.weights_[0]
        self.coef_ = self.weights_[1:]
        return self

    def predict(self, X):
        # TODO: prepend 1s, then return X_bias @ self.weights_
        return ...


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
df["date"] = pd.to_datetime(df["date"])
df["day_of_month"]  = df["date"].dt.day
df["is_payday_int"] = df["is_payday"].astype(int)
df["is_friday"]     = (df["day_of_week"] == "Friday").astype(int)

feature_cols = ["day_of_month", "is_payday_int", "is_friday"]
X = df[feature_cols].to_numpy(dtype=float)
y = df["revenue"].to_numpy(dtype=float)

# 80/20 split
rng = np.random.default_rng(42)
indices = rng.permutation(len(X))
n_test = int(len(X) * 0.2)
test_idx, train_idx = indices[:n_test], indices[n_test:]
X_train, X_test = X[train_idx], X[test_idx]
y_train, y_test = y[train_idx], y[test_idx]

# TODO: fit the model
model = LinearRegressionScratch()
# model.fit(X_train, y_train)

# TODO: predict on X_test, compute MAE
# TODO: print intercept and each feature weight
