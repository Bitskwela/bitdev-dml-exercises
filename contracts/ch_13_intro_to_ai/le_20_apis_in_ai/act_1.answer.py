# api_lab.py
# ============================================
# API LAB — Mock Carinderia API (Full Solution)
# by Dan Santos
# ============================================

import json


class MockCarinderiaAPI:
    """A mock API simulating GET/POST endpoints for a carinderia."""

    def __init__(self):
        self.menu = [
            {"name": "Adobo", "price": 60, "stock": 20},
            {"name": "Sinigang", "price": 65, "stock": 15},
            {"name": "Bistek", "price": 70, "stock": 12},
            {"name": "Tinola", "price": 55, "stock": 18},
            {"name": "Halo-Halo", "price": 60, "stock": 10},
        ]
        self.orders = []
        self.next_order_id = 1001

    def get_menu(self):
        return 200, {"menu": self.menu, "count": len(self.menu)}

    def get_menu_item(self, name):
        for item in self.menu:
            if item["name"].lower() == name.lower():
                return 200, item
        return 404, {"error": f"'{name}' not found in menu"}

    def post_order(self, item_name, qty):
        for item in self.menu:
            if item["name"].lower() == item_name.lower():
                if item["stock"] < qty:
                    return 400, {"error": f"Only {item['stock']} {item_name} left"}
                item["stock"] -= qty
                order = {
                    "order_id": self.next_order_id,
                    "item": item["name"],
                    "qty": qty,
                    "total": item["price"] * qty,
                }
                self.orders.append(order)
                self.next_order_id += 1
                return 201, order
        return 404, {"error": f"'{item_name}' not in menu"}

    def get_orders(self):
        total = sum(o["total"] for o in self.orders)
        return 200, {"orders": self.orders, "count": len(self.orders),
                     "grand_total": total}

    def get_recommendation(self, weather="sunny"):
        if weather.lower() == "rainy":
            return 200, {"recommendation": "Sinigang", "reason": "Hot soup for rainy weather"}
        if weather.lower() == "hot":
            return 200, {"recommendation": "Halo-Halo", "reason": "Cool down with this dessert"}
        return 200, {"recommendation": "Adobo", "reason": "The classic — never wrong"}

    def health(self):
        return 200, {"status": "ok", "uptime": "running"}


class CarinderiaClient:
    """A clean wrapper over the API for application code."""

    def __init__(self, api):
        self.api = api

    def get_menu(self):
        status, body = self.api.get_menu()
        if status == 200:
            return body["menu"]
        raise RuntimeError(body.get("error", "unknown"))

    def place_order(self, item, qty):
        status, body = self.api.post_order(item, qty)
        if status == 201:
            return body
        raise RuntimeError(body.get("error", "unknown"))

    def order_history(self):
        status, body = self.api.get_orders()
        return body

    def recommend(self, weather):
        status, body = self.api.get_recommendation(weather)
        return body["recommendation"]


# ============================================
# DEMO
# ============================================
print("=" * 55)
print("  API LAB — Mock Carinderia API Demo")
print("=" * 55)

# JSON round-trip
data = {"order_id": 1234, "items": ["Adobo", "Sinigang"], "total": 125.50}
text = json.dumps(data)
print(f"\n  Dict → JSON: {text}")
print(f"  JSON → Dict: {json.loads(text)}")

# Use the API directly
api = MockCarinderiaAPI()
print(f"\n  Health check: {api.health()}")

status, menu_body = api.get_menu()
print(f"  GET /menu     status={status}")
for item in menu_body["menu"]:
    print(f"     - {item['name']:10} P{item['price']} (stock: {item['stock']})")

status, _ = api.get_menu_item("LasagnA")
print(f"\n  GET /menu/LasagnA status={status}  (404 expected)")

# Place orders via the client wrapper
client = CarinderiaClient(api)

print("\n  -- Placing orders via CarinderiaClient --")
for item, qty in [("Adobo", 2), ("Sinigang", 1), ("Halo-Halo", 3), ("Bistek", 1)]:
    try:
        order = client.place_order(item, qty)
        print(f"     ✅ Ordered {qty}x {item}: order_id={order['order_id']} total=P{order['total']}")
    except RuntimeError as e:
        print(f"     ❌ {item}: {e}")

# Order history
history = client.order_history()
print(f"\n  Order history: {history['count']} orders, grand total P{history['grand_total']}")

# Recommendations
for weather in ["rainy", "hot", "cloudy"]:
    rec = client.recommend(weather)
    print(f"  Recommendation for {weather}: {rec}")

print("\n  💡 In real life, your code would use `requests.get(url)` to call a real server.")
print("     The pattern (status code + JSON body) is the same.")
