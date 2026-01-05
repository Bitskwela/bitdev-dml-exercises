# Le 26: Image Optimization – Faster Loading with Less Bandwidth

![Image Optimization](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/image-optimization.png)

## Background Story

Maria's barangay dashboard has lots of resident photos and document scans. Page load times are suffering.

"Why is the page so slow?" Maria asks, looking at the waterfall chart.

"Images," Marco points out. "They're 80% of your page weight. Let's optimize them."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Why image optimization matters
- Vercel Image Optimization
- Next.js Image component
- Image formats and quality
- Responsive images
- Lazy loading
- External image sources

---

## Why Image Optimization Matters

### The Problem

```
Unoptimized page:
- hero.jpg: 2.5 MB
- photo1.jpg: 1.2 MB
- photo2.jpg: 0.8 MB
- Total: 4.5 MB
- Load time: 8 seconds (slow 3G)

Optimized page:
- hero.webp: 150 KB
- photo1.webp: 80 KB
- photo2.webp: 50 KB
- Total: 280 KB
- Load time: 1.2 seconds (slow 3G)
```

### Key Benefits

| Benefit             | Impact                 |
| ------------------- | ---------------------- |
| Faster loading      | Better user experience |
| Lower bandwidth     | Cheaper for users      |
| Better SEO          | Google ranking factor  |
| Reduced CLS         | No layout shifts       |
| Lower hosting costs | Less data transfer     |

---

## Vercel Image Optimization

Vercel automatically optimizes images:

### How It Works

```
Original Request:
/_next/image?url=/hero.jpg&w=1200&q=75

Vercel:
1. Fetches original image
2. Resizes to requested width
3. Converts to modern format (WebP/AVIF)
4. Compresses at requested quality
5. Caches at edge
6. Serves optimized image
```

### Automatic Optimizations

- **Format conversion:** JPEG/PNG → WebP/AVIF
- **Resizing:** Match actual display size
- **Compression:** Quality optimization
- **Caching:** Edge caching for repeat visits

---

## Next.js Image Component

### Basic Usage

```tsx
import Image from "next/image";

export default function Profile() {
  return (
    <Image src="/resident.jpg" alt="Resident photo" width={300} height={400} />
  );
}
```

### Required Props

| Prop     | Description                |
| -------- | -------------------------- |
| `src`    | Image source (path or URL) |
| `alt`    | Accessibility text         |
| `width`  | Width in pixels            |
| `height` | Height in pixels           |

---

## Image Sizing

### Fixed Size

```tsx
<Image src="/logo.png" alt="Logo" width={200} height={50} />
```

### Fill Mode

```tsx
<div style={{ position: "relative", width: "100%", height: "400px" }}>
  <Image src="/hero.jpg" alt="Hero" fill style={{ objectFit: "cover" }} />
</div>
```

### Responsive Sizing

```tsx
<Image
  src="/banner.jpg"
  alt="Banner"
  width={1200}
  height={400}
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
/>
```

---

## Sizes Property

Tell browsers which size to download:

```tsx
<Image
  src="/photo.jpg"
  alt="Photo"
  width={1200}
  height={800}
  sizes="
    (max-width: 640px) 100vw,
    (max-width: 1024px) 50vw,
    33vw
  "
/>
```

### What This Means

| Viewport   | Image Size          |
| ---------- | ------------------- |
| < 640px    | 100% viewport width |
| 640-1024px | 50% viewport width  |
| > 1024px   | 33% viewport width  |

---

## Priority Loading

Preload above-the-fold images:

```tsx
// Hero image - loads immediately
<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority
/>

// Below fold - lazy loaded
<Image
  src="/photo.jpg"
  alt="Photo"
  width={400}
  height={300}
  // No priority = lazy loaded
/>
```

### When to Use Priority

✅ Hero images
✅ LCP (Largest Contentful Paint) element
✅ Above-the-fold images
❌ Images below the fold
❌ Images in carousels (hidden)

---

## Image Quality

### Default Quality (75)

```tsx
<Image
  src="/photo.jpg"
  alt="Photo"
  width={800}
  height={600}
  // quality defaults to 75
/>
```

### Custom Quality

```tsx
// High quality for important images
<Image
  src="/product.jpg"
  alt="Product"
  width={800}
  height={600}
  quality={90}
/>

// Lower quality for thumbnails
<Image
  src="/thumb.jpg"
  alt="Thumbnail"
  width={100}
  height={100}
  quality={60}
/>
```

### Quality Guidelines

| Use Case         | Quality |
| ---------------- | ------- |
| Thumbnails       | 50-60   |
| General photos   | 70-80   |
| Product images   | 80-90   |
| Text/screenshots | 90-100  |

---

## Placeholder Blur

Show blur placeholder while loading:

### Static Import (Automatic)

```tsx
import heroImage from "@/public/hero.jpg";

<Image
  src={heroImage}
  alt="Hero"
  placeholder="blur"
  // blurDataURL automatically generated
/>;
```

### Remote Images (Manual)

```tsx
<Image
  src="https://example.com/photo.jpg"
  alt="Photo"
  width={800}
  height={600}
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,/9j/4AAQ..."
/>
```

### Generating Blur Data URL

```tsx
// Use a library like plaiceholder
import { getPlaiceholder } from "plaiceholder";

const { base64 } = await getPlaiceholder("/path/to/image.jpg");
```

---

## External Images

### Configure Domains

```javascript
// next.config.js
module.exports = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "images.example.com",
        pathname: "/photos/**",
      },
      {
        protocol: "https",
        hostname: "*.cloudinary.com",
      },
    ],
  },
};
```

### Using Remote Images

```tsx
<Image
  src="https://images.example.com/photos/resident.jpg"
  alt="Resident"
  width={300}
  height={400}
/>
```

---

## Image Formats

### Automatic Format Selection

Vercel serves the best format:

| Browser        | Format Served |
| -------------- | ------------- |
| Modern Chrome  | AVIF          |
| Modern Firefox | WebP          |
| Safari 14+     | WebP          |
| Older browsers | JPEG          |

### Format Comparison

| Format | Quality | Size        | Support   |
| ------ | ------- | ----------- | --------- |
| JPEG   | Good    | Large       | Universal |
| WebP   | Better  | 30% smaller | 97%+      |
| AVIF   | Best    | 50% smaller | 85%+      |

---

## Common Patterns

### Hero Image

```tsx
<section className="relative h-[500px]">
  <Image
    src="/hero.jpg"
    alt="Welcome to Barangay"
    fill
    priority
    style={{ objectFit: "cover" }}
    sizes="100vw"
  />
  <div className="absolute inset-0 bg-black/40">
    <h1>Welcome to Our Barangay</h1>
  </div>
</section>
```

### Image Gallery

```tsx
function Gallery({ images }) {
  return (
    <div className="grid grid-cols-3 gap-4">
      {images.map((img, i) => (
        <div key={i} className="relative aspect-square">
          <Image
            src={img.url}
            alt={img.alt}
            fill
            sizes="(max-width: 768px) 100vw, 33vw"
            style={{ objectFit: "cover" }}
          />
        </div>
      ))}
    </div>
  );
}
```

### Avatar

```tsx
function Avatar({ user }) {
  return (
    <Image
      src={user.avatar || "/default-avatar.png"}
      alt={user.name}
      width={48}
      height={48}
      className="rounded-full"
    />
  );
}
```

---

## Vercel Image Optimization Limits

| Plan       | Optimized Images |
| ---------- | ---------------- |
| Hobby      | 1,000/month      |
| Pro        | 5,000/month      |
| Enterprise | Unlimited        |

### Managing Usage

1. Use static imports when possible
2. Set appropriate sizes
3. Cache images properly
4. Monitor usage in dashboard

---

## Debugging Image Issues

### Image Not Optimizing

```tsx
// Check if src is configured
// next.config.js must include remote pattern
```

### Wrong Size Loading

```tsx
// Use browser DevTools
// Network tab → Img filter
// Check actual size requested vs needed
```

### Layout Shift (CLS)

```tsx
// Always specify width and height
// Or use fill with container dimensions
```

---

## Maria's Image Optimization

Maria optimizes her resident dashboard:

**Before:**

```tsx
// Slow, unoptimized
<img src="/resident.jpg" />
```

**After:**

```tsx
// Fast, optimized
<Image
  src="/resident.jpg"
  alt="Resident photo"
  width={150}
  height={150}
  className="rounded-full"
  placeholder="blur"
/>
```

**Results:**

- Image size: 1.2MB → 45KB
- LCP: 4.2s → 1.8s
- CLS: 0.15 → 0.02

---

## Key Takeaways

✓ Use Next.js Image component for automatic optimization
✓ Set width, height, and alt for every image
✓ Use priority for above-the-fold images
✓ Add sizes prop for responsive images
✓ Configure remote patterns for external images
✓ Use placeholder="blur" for better UX

**Next Lesson:** Vercel Firewall—protecting your application from threats!
