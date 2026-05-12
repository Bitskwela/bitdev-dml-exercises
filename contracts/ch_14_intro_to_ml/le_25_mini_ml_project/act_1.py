# ============================================
# LUTO v2 — Mini ML Project
# by: <Your Name>
# ============================================
# Given tomorrow's (date, weather, is_payday) — predict top 3 ulam.
# ============================================

import io
import pickle
import numpy as np
import pandas as pd
from datetime import datetime, timedelta

ITEMS = ["Adobo", "Sinigang", "Kare-Kare", "Bistek",
         "Tinola", "Pinakbet", "Lechon Kawali"]


# TODO: copy LinearRegressionScratch from Lesson 9


SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-09-01,Adobo,11,825,Monday,False,rainy
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-15,Sinigang,17,1275,Monday,True,sunny
2025-09-30,Adobo,16,1280,Tuesday,True,sunny
2025-10-15,Kare-Kare,17,2006,Wednesday,True,rainy
2025-10-30,Sinigang,19,1425,Thursday,True,cloudy
2025-11-08,Bistek,11,1045,Saturday,False,sunny
2025-11-15,Adobo,15,1200,Saturday,True,sunny
2025-12-01,Tinola,8,640,Monday,False,sunny
2025-12-15,Kare-Kare,19,2233,Monday,True,rainy
2025-12-30,Sinigang,22,1650,Tuesday,True,rainy
2026-01-08,Bistek,12,1140,Thursday,False,sunny
2026-01-15,Adobo,17,1360,Friday,True,sunny
2026-01-30,Kare-Kare,18,2124,Friday,True,sunny
"""

# TODO: full pipeline
# 1. Load CSV; fix dtypes
# 2. Engineer features:
#    - is_payday_int, is_friday, is_rainy, day_of_month
#    - one-hot encode item (drop_first=True)
# 3. Split 80/20
# 4. Train LinearRegressionScratch on revenue
# 5. Test MAE
# 6. Serialize via pickle.dumps
# 7. For tomorrow's (date, weather, is_payday):
#    - Build 7 feature rows (one per ulam)
#    - Predict expected revenue for each
#    - Sort descending
#    - Print top 3

print("Stub — fill in the pipeline above")
