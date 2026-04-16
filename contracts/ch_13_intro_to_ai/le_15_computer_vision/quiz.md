# Lesson 15 Quiz: Computer Vision

---
# Quiz 1
## Scenario: Facebook Food Photos
Dan photographed dishes for his mom's page and wondered how AI could classify them.

**Question 1:** An image is stored as:
A. A single string
B. A 3D array of shape (height, width, 3) with RGB values
C. A list of pixels
D. A JSON object

**Answer:** B
**Explanation:** Images are 3D arrays — each pixel has 3 channel values (Red, Green, Blue) from 0 to 255.

---

**Question 2:** What does each RGB channel value represent?
A. Alpha transparency
B. A color intensity from 0 (none) to 255 (max)
C. Brightness in percent
D. A random pixel

**Answer:** B
**Explanation:** Each of R, G, B is an integer 0-255. `[255, 0, 0]` = pure red. `[255, 255, 255]` = white.

---

**Question 3:** How do you convert an RGB image to grayscale?
A. Delete one channel
B. Average the three channels to get a single brightness value per pixel
C. Multiply by 0
D. You can't

**Answer:** B
**Explanation:** `gray = image.mean(axis=2)` collapses the 3 RGB channels into 1 brightness channel.

---

**Question 4:** Approximately how many numbers are in a 1080x1920 RGB photo?
A. 100
B. 100,000
C. About 6 million
D. 1 billion

**Answer:** C
**Explanation:** 1080 × 1920 × 3 = 6,220,800 numbers. AI on images means processing massive arrays.

---

**Question 5:** What is the primary modern technique for computer vision?
A. Simple averaging
B. Convolutional Neural Networks (CNNs)
C. Binary search
D. Regex

**Answer:** B
**Explanation:** CNNs automatically learn features (edges → shapes → parts → objects) from pixels. They're the backbone of modern image classification, object detection, and face recognition.

---
# Quiz 2
## Scenario: Classifier Limits
Dan's color classifier confused Adobo and Bistek (both brown).

**Question 6:** Why did Dan's color-based classifier confuse Adobo and Bistek?
A. The images were blurry
B. Both dishes have similar average brown color — color alone isn't enough
C. The computer was slow
D. His Python was outdated

**Answer:** B
**Explanation:** Color averaging loses texture and shape information. Real CNNs look at all three together — which is why they can distinguish visually similar dishes.

---

**Question 7:** Which is NOT a typical computer vision task?
A. Face recognition
B. OCR (reading text in images)
C. Image classification
D. Sorting a list of numbers

**Answer:** D
**Explanation:** Sorting numbers is a general algorithm, not a CV task. CV tasks deal with pixels: classification, detection, segmentation, OCR, face recognition, etc.

---
**Next:** Proceed to Lesson 15 exercises.
