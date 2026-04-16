# api_lab.py
# ============================================
# API LAB — Mock Carinderia API
# by: <Your Name>
# ============================================

import json

print("=" * 55)
print("  API LAB — Mock Carinderia API")
print("=" * 55)

# Task 1: JSON round-trip
data = {"order_id": 1234, "items": ["Adobo", "Sinigang"], "total": 125.50}
text = json.dumps(data)
back = json.loads(text)
print(f"\n  JSON text: {text}")
print(f"  Back to dict: {back}")


# TODO: Task 2 — MockCarinderiaAPI class with 6 endpoints
# class MockCarinderiaAPI:
#     def __init__(self):
#         self.menu = [...]
#         self.orders = []
#
#     def get_menu(self): -> (200, {...})
#     def get_menu_item(self, name): -> (200, {...}) or (404, {...})
#     def post_order(self, item, qty): -> (201, {...})
#     def get_orders(self): -> (200, {...})
#     def get_recommendation(self, weather): -> (200, {...})
#     def health(self): -> (200, {"status": "ok"})


# TODO: Task 3 — CarinderiaClient wrapper
# class CarinderiaClient:
#     def __init__(self, api): self.api = api
#     def get_menu(self): -> calls api, returns parsed dict


# TODO: Demo: instantiate api, wrap in client, exercise all endpoints
