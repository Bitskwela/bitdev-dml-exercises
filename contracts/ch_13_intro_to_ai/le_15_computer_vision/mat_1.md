## Previously on Dan's AI Journey...

Dan built an NLP analyzer that turned 20 customer reviews into actionable business insights.

---

## Background Story

Tita Malou pushed her phone at Dan. "Anak, photograph the dishes nga for our Facebook page. People see food, people come eat."

Dan snapped 15 shots of adobo, sinigang, kare-kare, turon, and halo-halo. He uploaded them. Then he wondered: could AI automatically tell which dish is in each photo? Because manually labeling every photo for 15 years of business was impossible.

He messaged Kuya JM.

> **Dan:** *"Kuya, how does AI see images? Is it magic?"*
>
> **Kuya JM:** *"No magic. Every image is just a grid of numbers. Each pixel = 3 numbers for Red, Green, Blue (0-255 each). A 4000x3000 phone photo = 12 million pixels = 36 million numbers. To a computer, your adobo photo is a huge matrix of numbers. AI operations on it are just math on matrices."*
>
> **Kuya JM:** *"Classic computer vision techniques: grayscale conversion, brightness detection, color analysis, edge detection. Modern CV uses convolutional neural networks (CNNs) that automatically learn features from pixels."*

Dan was fascinated. That night he built tools:
- Created a Philippine flag from scratch using just RGB arrays
- A brightness detector that identified which food photos were too dark to post
- A color analyzer that classified food by dominant hue (Adobo = brown, Sinigang = yellow-brown, Kare-Kare = orange)

All without loading any external image. Just numpy and PIL generating images programmatically.

---

## Theory & Lecture Content

### Pixels and RGB

An image is a 3D array of shape `(height, width, 3)`:
- Height and width = pixel dimensions
- 3 = color channels (Red, Green, Blue)

Each channel value is 0-255.

- Pure red = `[255, 0, 0]`
- Pure green = `[0, 255, 0]`
- Pure blue = `[0, 0, 255]`
- White = `[255, 255, 255]`
- Black = `[0, 0, 0]`

### Common CV Tasks

| Task | What It Does | Example |
|------|--------------|---------|
| **Image classification** | What's in the image? | "This is an adobo photo" |
| **Object detection** | Where is it? | Bounding boxes around people |
| **Face recognition** | Who is it? | Tita Malou in the photo |
| **Segmentation** | Pixel-level labels | Every pixel marked food/plate/table |
| **OCR** | Read text in images | Menu board photo → text |
| **Style transfer** | Re-style an image | Photo in Van Gogh's style |

### Grayscale Conversion

Averaging the 3 channels collapses color into a single brightness value (0-255):

```python
gray = np.mean(image, axis=2)   # average across RGB axis
```

### Brightness Detection

Average all pixels to get overall brightness:

```python
brightness = np.mean(image)  # 0 (black) to 255 (white)
```

A food photo with brightness < 100 is likely too dark to post.

### Color Analysis

Extract dominant colors by averaging per channel:

```python
avg_red = np.mean(image[:, :, 0])
avg_green = np.mean(image[:, :, 1])
avg_blue = np.mean(image[:, :, 2])
```

Compare to known dish color profiles:
- Adobo: mostly brown → `[90, 50, 30]`
- Sinigang: yellow-brown broth → `[150, 120, 70]`
- Kare-Kare: orange → `[190, 110, 50]`

Closest match = predicted dish.

### Modern CV: CNNs

Convolutional Neural Networks process images through specialized layers:
- **Convolutional layers**: detect edges and patterns
- **Pooling layers**: downsample while preserving key info
- **Dense layers**: final classification

Pretrained models like ResNet, EfficientNet, or Vision Transformers can identify thousands of object classes out of the box.

---

## Key Takeaways

1. **Images are 3D numpy arrays** of shape (height, width, 3) — RGB channels.
2. **Each pixel is 3 numbers (0-255)**. A full HD photo = 6 million numbers.
3. **Grayscale = average RGB**. Loses color but keeps brightness.
4. **Brightness detection** = mean of all pixel values.
5. **Color classification** by comparing dominant RGB to known profiles.
6. **Modern CV** uses CNNs — they automatically learn edges, shapes, and objects from pixels.

---

## What's Next?

NLP and CV handle different modalities. But there's a third branch — where AI learns by trial and error, through rewards.

**Next Lesson: Reinforcement Learning** — Dan trains a delivery agent to navigate Marikina.

**Next:** Quiz then exercises.
