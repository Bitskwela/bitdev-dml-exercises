# ============================================
# DATASET EXPLORATION — Lesson 6
# by: <Your Name>
# ============================================
# Load 30 rows of carinderia sales (inline CSV).
# Run head/info/describe/value_counts. Fix dtypes. Find patterns.
# ============================================

import pandas as pd
from io import StringIO

# 30-row representative subset of Tita Malou's 8-month notebook.
# The full 977-row dataset lives in the standalone Intro-to-ML repo.
SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-01,Lechon Kawali,5,685,Friday,False,cloudy
2025-08-01,Tinola,13,910,Friday,False,cloudy
2025-08-02,Tinola,9,603,Saturday,False,rainy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-02,Pinakbet,8,496,Saturday,False,rainy
2025-08-02,Adobo,14,1050,Saturday,False,rainy
2025-08-03,Sinigang,15,975,Sunday,False,sunny
2025-08-03,Lechon Kawali,11,1540,Sunday,False,sunny
2025-08-05,Tinola,8,560,Tuesday,False,cloudy
2025-08-06,Adobo,10,820,Wednesday,False,sunny
2025-08-07,Bistek,9,720,Thursday,False,sunny
2025-08-08,Sinigang,12,780,Friday,False,sunny
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-15,Adobo,16,1240,Friday,True,rainy
2025-08-16,Adobo,12,960,Saturday,False,rainy
2025-08-18,Tinola,6,420,Monday,False,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-23,Kare-Kare,10,1180,Saturday,False,sunny
2025-08-25,Pinakbet,5,310,Monday,False,rainy
2025-08-29,Bistek,13,1235,Friday,False,sunny
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-08-30,Kare-Kare,16,1888,Saturday,True,sunny
2025-08-30,Adobo,18,1440,Saturday,True,sunny
2025-09-01,Adobo,11,825,Monday,False,rainy
2025-09-02,Tinola,7,490,Tuesday,False,rainy
2025-09-05,Sinigang,13,845,Friday,False,sunny
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-15,Sinigang,17,1275,Monday,True,sunny
"""

# TODO: load into df via pd.read_csv(StringIO(...))
df = ...

# TODO: print df.head(), df.info(), df.describe()

# TODO: print value_counts for item and weather

# TODO: fix dtypes — is_payday string→bool, date string→datetime

# TODO: groupby is_payday + mean revenue
# TODO: filter rainy days, groupby item + sum quantity, sort descending
# TODO: groupby [day_of_week, is_payday] + sum revenue
