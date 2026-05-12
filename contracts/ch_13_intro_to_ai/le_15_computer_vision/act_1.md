# Computer Vision Lab

See how AI views images — as grids of numbers. Build a brightness detector and a color-based dish classifier.

---

## Prerequisites

```
pip install numpy
```

(Pillow is optional — we'll use numpy only to keep things self-contained.)

---

## Task 1: Create an Image from Scratch

Create a Philippine flag programmatically:

```python
import numpy as np

# 300 rows, 600 cols, 3 channels (RGB)
flag = np.zeros((300, 600, 3), dtype=np.uint8)

# Blue top half
flag[:150, :] = [0, 56, 168]

# Red bottom half
flag[150:, :] = [206, 17, 38]

# White triangle on the left (simplified)
for i in range(150):
    for j in range(300 - i * 2):
        flag[150 - i:150 + i, j:j+1] = [255, 255, 255]  # approximate
```

Print the shape and total pixel count.

---

## Task 2: Examine Pixels

```python
print("Top-left pixel:", flag[0, 0])
print("Bottom-right pixel:", flag[299, 599])
print("Average of entire image:", flag.mean(axis=(0, 1)))
```

---

## Task 3: Grayscale Conversion

```python
gray = flag.mean(axis=2)  # collapse RGB → single brightness value
print("Grayscale shape:", gray.shape)
print("Brightness range:", gray.min(), "to", gray.max())
```

---

## Task 4: Food Photo Brightness Detector

Generate synthetic "food photos" at different lighting levels. Detect which are too dark to post to Facebook.

```python
def brightness(img):
    return img.mean()

def is_too_dark(img, threshold=100):
    return brightness(img) < threshold
```

---

## Task 5: Color-Based Dish Classifier

Define color profiles for 4 dishes:

```python
DISH_COLORS = {
    "Adobo":     [90, 50, 30],
    "Sinigang":  [150, 120, 70],
    "Kare-Kare": [190, 110, 50],
    "Halo-Halo": [220, 180, 200],
}
```

For an input image, compute its average color and find the closest match (Euclidean distance).

---

## Challenge: Color Swatch Comparison

Generate synthetic food color swatches and classify each. Measure accuracy.

### Bonus: Mystery Dish

Given an unknown average-color input, the system should:
- Guess the closest dish
- Report confidence (1 - normalized distance)
- Flag if all candidates are too far (unknown dish)

---

## What You've Learned

- Images as numpy arrays (height, width, 3)
- RGB channel values (0-255)
- Grayscale via averaging channels
- Brightness detection via mean
- Color-based classification via nearest-neighbor on RGB space
- Why modern CV (CNNs) uses learned features instead of hand-coded color rules

Next up: **Reinforcement Learning** — Dan trains a delivery agent.
