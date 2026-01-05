# Image Optimization Activity

Images are often the largest assets on a page. In this activity, you'll optimize images using Next.js and Vercel.

## Task for Students

### Part 1: Image Optimization Quiz

**Question 1:** What format does Vercel serve to modern browsers?

- A) JPEG only
- B) PNG only
- C) WebP or AVIF
- D) GIF

**Question 2:** Which prop preloads an image immediately?

- A) lazy
- B) priority
- C) preload
- D) eager

**Question 3:** Why must you specify width and height?

- A) For styling
- B) To prevent layout shifts (CLS)
- C) For SEO
- D) For caching

**Question 4:** What does the `sizes` prop do?

- A) Sets file size limit
- B) Tells browser which image size to download
- C) Limits quality
- D) Sets cache duration

**Question 5:** What is the default quality setting?

- A) 50
- B) 75
- C) 90
- D) 100

---

### Part 2: Convert to Next.js Image

**Task:** Convert these unoptimized images to use Next.js Image:

**Before:**

```tsx
export default function Page() {
  return (
    <div>
      <img src="/hero.jpg" alt="Hero" />
      <img src="/photo.jpg" alt="Photo" />
    </div>
  );
}
```

**After:**

```tsx
import Image from "next/image";

export default function Page() {
  return (
    <div>
      <Image
        src="/hero.jpg"
        alt="Hero"
        width={1200}
        height={600}
        priority // Above the fold
      />
      <Image
        src="/photo.jpg"
        alt="Photo"
        width={800}
        height={600}
        // No priority = lazy loaded
      />
    </div>
  );
}
```

---

### Part 3: Implement Responsive Images

**Task:** Add proper sizes for responsive layout:

```tsx
// Full width on mobile, half on tablet, third on desktop
<Image
  src="/banner.jpg"
  alt="Banner"
  width={1200}
  height={400}
  sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
/>
```

**Exercise:** Write the sizes for:

1. Full width on all screens:

   ```tsx
   sizes = "___";
   ```

2. Full width mobile, 50% desktop:

   ```tsx
   sizes = "___";
   ```

3. 100px fixed width:
   ```tsx
   sizes = "___";
   ```

---

### Part 4: Hero Image with Fill

**Task:** Create a hero section with full-width background:

```tsx
export default function HeroSection() {
  return (
    <section className="relative h-[500px]">
      <Image
        src="/hero.jpg"
        alt="Welcome to Barangay Dashboard"
        fill
        priority
        style={{ objectFit: "cover" }}
        sizes="100vw"
        quality={85}
      />
      <div className="absolute inset-0 bg-black/50 flex items-center justify-center">
        <h1 className="text-white text-4xl font-bold">
          Welcome to Our Barangay
        </h1>
      </div>
    </section>
  );
}
```

**Questions:**

1. Why use `fill` instead of width/height? \_\_\_

2. Why is `priority` added? \_\_\_

3. What does `objectFit: 'cover'` do? \_\_\_

---

### Part 5: Configure Remote Images

**Task:** Configure external image sources:

```javascript
// next.config.js
module.exports = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "images.unsplash.com",
      },
      {
        protocol: "https",
        hostname: "*.cloudinary.com",
      },
      {
        protocol: "https",
        hostname: "barangay-assets.s3.amazonaws.com",
        pathname: "/residents/**",
      },
    ],
  },
};
```

**Now use remote images:**

```tsx
<Image
  src="https://images.unsplash.com/photo-123"
  alt="Barangay scene"
  width={800}
  height={600}
/>
```

---

### Part 6: Add Blur Placeholder

**Task:** Implement blur placeholder for images:

**Static Import (automatic blur):**

```tsx
import heroImage from "@/public/hero.jpg";

<Image
  src={heroImage}
  alt="Hero"
  placeholder="blur"
  // blurDataURL is automatic
/>;
```

**Remote Image (manual blur):**

```tsx
<Image
  src="https://example.com/photo.jpg"
  alt="Photo"
  width={800}
  height={600}
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAIAAoDASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUH/8QAHBAAAgIDAQEAAAAAAAAAAAAAAQIAAwQRITES/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAX/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwDXc3LqxiVJQwv1vFVEH0oiQf/Z"
/>
```

---

### Part 7: Create an Image Gallery

**Task:** Build an optimized image gallery:

```tsx
interface GalleryImage {
  src: string;
  alt: string;
}

function ImageGallery({ images }: { images: GalleryImage[] }) {
  return (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
      {images.map((image, index) => (
        <div key={index} className="relative aspect-square">
          <Image
            src={image.src}
            alt={image.alt}
            fill
            sizes="(max-width: 768px) 50vw, (max-width: 1024px) 33vw, 25vw"
            style={{ objectFit: "cover" }}
            className="rounded-lg"
          />
        </div>
      ))}
    </div>
  );
}
```

**Usage:**

```tsx
const images = [
  { src: "/photo1.jpg", alt: "Photo 1" },
  { src: "/photo2.jpg", alt: "Photo 2" },
  // ...
];

<ImageGallery images={images} />;
```

---

### Part 8: Avatar Component

**Task:** Create a reusable avatar component:

```tsx
interface AvatarProps {
  src?: string;
  alt: string;
  size?: "sm" | "md" | "lg";
}

const sizes = {
  sm: 32,
  md: 48,
  lg: 64,
};

export function Avatar({ src, alt, size = "md" }: AvatarProps) {
  const dimension = sizes[size];

  return (
    <Image
      src={src || "/default-avatar.png"}
      alt={alt}
      width={dimension}
      height={dimension}
      className="rounded-full object-cover"
    />
  );
}
```

**Usage:**

```tsx
<Avatar src="/users/maria.jpg" alt="Maria" size="lg" />
<Avatar alt="Guest" /> {/* Uses default */}
```

---

### Part 9: Quality Optimization

**Match the use case with the appropriate quality:**

| Use Case          | Quality |
| ----------------- | ------- |
| Thumbnails        | \_\_\_  |
| Hero images       | \_\_\_  |
| Product photos    | \_\_\_  |
| Screenshots       | \_\_\_  |
| Background images | \_\_\_  |

**Options:** 50, 60, 75, 85, 95

---

### Part 10: Debug Image Issues

**Scenario:** Your images aren't being optimized. Debug:

**Issue 1:** Remote image not loading

```tsx
<Image
  src="https://new-domain.com/photo.jpg"
  alt="Photo"
  width={800}
  height={600}
/>
```

**Error:** `next/image` hostname not configured

**Fix:** ******\_\_\_******

**Issue 2:** Layout shift occurring

```tsx
<Image src="/photo.jpg" alt="Photo" />
```

**Error:** Missing width/height

**Fix:** ******\_\_\_******

**Issue 3:** Image too large being downloaded

```tsx
<Image
  src="/photo.jpg"
  alt="Photo"
  width={1920}
  height={1080}
  // Displayed at 200x112 on mobile
/>
```

**Fix:** ******\_\_\_******

---

### What You Learned

✓ Using Next.js Image component
✓ Setting width, height, and alt props
✓ Using priority for LCP images
✓ Implementing responsive images with sizes
✓ Configuring remote image patterns
✓ Adding blur placeholders

---

**Instructor Answers:**

Part 1: 1-C, 2-B, 3-B, 4-B, 5-B

Part 3:

1. `sizes="100vw"`
2. `sizes="(max-width: 768px) 100vw, 50vw"`
3. `sizes="100px"`

Part 4:

1. Image fills container, container controls size
2. It's the LCP element above the fold
3. Scales image to cover container while maintaining aspect ratio

Part 9:

- Thumbnails: 50-60
- Hero images: 80-85
- Product photos: 85-90
- Screenshots: 90-95
- Background images: 70-75

Part 10:

- Issue 1 Fix: Add hostname to `next.config.js` remotePatterns
- Issue 2 Fix: Add `width` and `height` props
- Issue 3 Fix: Add `sizes="(max-width: 768px) 100vw, 200px"`
