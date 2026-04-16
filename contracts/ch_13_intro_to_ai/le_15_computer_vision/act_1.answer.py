# computer_vision_lab.py
# ============================================
# COMPUTER VISION LAB — Full Solution
# by Dan Santos
# ============================================

import numpy as np

print("=" * 55)
print("  COMPUTER VISION LAB")
print("=" * 55)

# Task 1: Create an image from scratch (simplified Philippine flag)
flag = np.zeros((300, 600, 3), dtype=np.uint8)
flag[:150, :] = [0, 56, 168]     # blue top
flag[150:, :] = [206, 17, 38]    # red bottom
# Simplified white triangle on the left
for i in range(150):
    width = int(300 * (1 - i / 150))
    flag[150 - i // 2:150 + i // 2, :width // 2] = [255, 255, 255]

print(f"\n-- Task 1: Flag generated --")
print(f"   Shape: {flag.shape}")
print(f"   Total pixels: {flag.shape[0] * flag.shape[1]:,}")
print(f"   Total numbers (3 channels): {flag.size:,}")

# Task 2: Examine pixels
print(f"\n-- Task 2: Pixel examination --")
print(f"   Top-left (blue area):    {flag[50, 300]}")
print(f"   Bottom-right (red area): {flag[250, 500]}")
print(f"   Top-left (white area):   {flag[120, 20]}")
print(f"   Average RGB of image:    {flag.mean(axis=(0, 1)).round(1)}")

# Task 3: Grayscale
gray = flag.mean(axis=2)
print(f"\n-- Task 3: Grayscale --")
print(f"   Shape: {gray.shape}")
print(f"   Brightness range: {gray.min():.0f} to {gray.max():.0f}")
print(f"   Average brightness: {gray.mean():.1f}")

# Task 4: Brightness detector on 5 synthetic food photos
def brightness(img):
    return float(img.mean())

def is_too_dark(img, threshold=100):
    return brightness(img) < threshold

print(f"\n-- Task 4: Brightness Detector --")
photos = {
    "Sunlight photo":      np.full((100, 100, 3), 220, dtype=np.uint8),
    "Indoor lighting":     np.full((100, 100, 3), 150, dtype=np.uint8),
    "Dim kitchen":         np.full((100, 100, 3), 90,  dtype=np.uint8),
    "Night (no flash)":    np.full((100, 100, 3), 40,  dtype=np.uint8),
    "Reasonable":          np.full((100, 100, 3), 130, dtype=np.uint8),
}
for name, img in photos.items():
    b = brightness(img)
    verdict = "❌ TOO DARK — retake" if is_too_dark(img) else "✅ OK to post"
    print(f"   {name:22} brightness={b:>5.1f}  {verdict}")

# Task 5: Color-based dish classifier
DISH_COLORS = {
    "Adobo":     np.array([90,  50,  30]),
    "Sinigang":  np.array([150, 120, 70]),
    "Kare-Kare": np.array([190, 110, 50]),
    "Halo-Halo": np.array([220, 180, 200]),
}

def classify_dish(avg_color):
    best = None
    best_dist = float("inf")
    for name, color in DISH_COLORS.items():
        dist = np.linalg.norm(avg_color - color)
        if dist < best_dist:
            best = name
            best_dist = dist
    confidence = max(0, 1 - best_dist / 300)
    return best, best_dist, confidence

print(f"\n-- Task 5: Dish Classifier --")
mystery_images = {
    "Dish A (brown-ish)":  np.array([95, 55, 35]),
    "Dish B (orange)":     np.array([185, 105, 55]),
    "Dish C (yellow)":     np.array([155, 125, 75]),
    "Dish D (pastel mix)": np.array([215, 175, 195]),
    "Dish E (unknown)":    np.array([50, 200, 100]),
}

correct_answers = ["Adobo", "Kare-Kare", "Sinigang", "Halo-Halo", "???"]

for (name, color), answer in zip(mystery_images.items(), correct_answers):
    dish, dist, conf = classify_dish(color)
    hit = "✓" if dish == answer else "" if answer == "???" else "✗"
    print(f"   {name:22} avg={str(color):15} → {dish:<10} "
          f"(dist={dist:5.1f}, conf={conf:.2f}) {hit}")

# Challenge: Synthetic food swatches + accuracy
print(f"\n-- Challenge: Accuracy on 4 clean swatches --")
correct = 0
total = 0
for true_dish, color in DISH_COLORS.items():
    total += 1
    pred, _, _ = classify_dish(color)
    if pred == true_dish:
        correct += 1
print(f"   {correct}/{total} correctly classified = {correct/total*100:.0f}%")
print(f"   (Real CNNs handle texture + shape + color together — "
      f"way more accurate than this simple nearest-RGB approach.)")
