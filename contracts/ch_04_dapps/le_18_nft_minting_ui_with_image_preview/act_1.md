# NFT Image Preview Activity

**Goal:** turn a chosen image file into an on-screen preview, and show the NFT metadata JSON (name, description, image) that a minting step would later use.

Lakan the spoken-word poet wants to see his NFT *before* anything goes on-chain. You will build `NFTPreview`, the preview card. It receives a title, a description and the image `File` the user picked, and it shows the picture plus the metadata JSON. Nothing is minted here: no wallet, no transaction, just an honest preview.

## Initial Code

```js
// NFTPreview.js - Starter Code
import React from "react";

export default function NFTPreview({ title, description, file }) {
  // TODO: Task 1 - When no file has been chosen yet, ask for one instead of
  //                rendering a broken image

  // TODO: Task 2 - Turn the File into a previewable URL

  // TODO: Task 3 - Build the metadata object (name, description, image) and
  //                render the image, the title, the description, and the JSON

  return <p>Placeholder</p>;
}
```

**Time Allotment: 20 minutes**

> **Where do the props come from?** In a real app, a parent form owns the title and description inputs and an `<input type="file" accept="image/*">`. It passes `e.target.files[0]` down as `file`. The grader plays that parent: it passes the title `"Sarimanok sa Umaga"`, the description `"Woodblock print, Angono"`, and a PNG file. It also renders your card with no file, and with an empty title.

## Tasks for Learners

Topics Covered: guard clauses, `URL.createObjectURL()`, the NFT metadata shape, `JSON.stringify` formatting, conditional rendering

The numbered tasks match the `TODO` comments in the starter.

---

### Task 1: Ask for a file when there is none

Before the user picks an image, `file` is `null`. `URL.createObjectURL(null)` throws, so return early with a prompt. This early `return` is called a **guard clause**: it handles the edge case first, so the rest of the function can assume a file exists.

Replace the `TODO: Task 1` comment with:

```js
// Task 1: Handle missing file case
if (!file) {
  return <p>Please upload an image to preview your NFT.</p>;
}
```

**Required:** the prompt must contain one of the words **upload**, **choose**, **select** or **pick**, in any capitalisation. "Please upload an image..." does.

---

### Task 2: Turn the File into a previewable URL

A `File` object is data in memory, not an address, so `<img src={file}>` does not work. `URL.createObjectURL(file)` gives that data a temporary address that starts with `blob:`, and an `<img>` can display it.

Replace the `TODO: Task 2` comment with:

```js
// Task 2: Create object URL for image preview
const imageUrl = URL.createObjectURL(file);
```

---

### Task 3: Build the metadata and render the card

NFT marketplaces read a small JSON document per token, with at least `name`, `description` and `image`. Build that object, falling back to `"Untitled"` when the title is empty, and render it next to the image.

Replace the `TODO: Task 3` comment **and** the starter's `return <p>Placeholder</p>;` with:

```js
// Task 3: Build metadata object and render preview UI
const metadata = {
  name: title || "Untitled",
  description: description || "",
  image: imageUrl,
};

return (
  <div style={{ border: "1px solid #ccc", padding: 16 }}>
    <h4>Image Preview</h4>
    <img
      src={imageUrl}
      alt="NFT preview"
      style={{ maxWidth: "100%", maxHeight: 200 }}
    />
    <h4>{metadata.name}</h4>
    <p>{metadata.description}</p>
    <h5>Metadata JSON:</h5>
    <pre style={{ background: "#f9f9f9", padding: 8 }}>
      {JSON.stringify(metadata, null, 2)}
    </pre>
  </div>
);
```

`JSON.stringify(metadata, null, 2)` prints the object with 2-space indentation. Inside a `<pre>`, it stays readable.

---

> **Graded details: labels and wording are checked.** The grader checks all of these:
>
> - With `file` set to `null`, the text matches **upload / choose / select / pick**. "Add your art" fails, even though it means the same thing.
> - With `file` set to `null`, `URL.createObjectURL` is **never called**. The guard must come first.
> - With a file, `URL.createObjectURL(file)` is called, and the **first** `<img>` on the card has that `blob:` URL as its `src`.
> - The title `Sarimanok sa Umaga` and the description `Woodblock print, Angono` both appear.
> - The rendered JSON contains the keys `name`, `description` and `image`.
> - With an empty title, the card shows `Untitled`.

## Two honest notes about this code

1. **It leaks a little memory.** Each object URL keeps its file in memory until the page closes or someone calls `URL.revokeObjectURL(url)`. The code above creates a fresh URL on **every render** and never revokes any of them. For a single card in a lesson the leak is harmless, and the grader accepts it. In a real app, create the URL once per file and revoke it when the file changes. The lecture shows the `useMemo` + `useEffect` version, and the grader accepts that too.
2. **A `blob:` URL is not valid NFT metadata.** It only works inside the browser tab that created it. Anyone else, including OpenSea and a collector's wallet, would get nothing. Here it is used only to preview the card. Before minting, you upload the image to permanent storage (for example IPFS) and replace `image` with that address (`ipfs://...`). The lecture walks through that step.

## Common mistakes

| Mistake | What happens | Fix |
| ------- | ------------ | --- |
| `<img src={file}>` | Broken image: a File is not a URL | `URL.createObjectURL(file)` |
| Calling `createObjectURL` before the guard | Throws on `null`, and fails the "no URL" check | Put the `if (!file)` guard first |
| Prompt says "Add your art" | Fails the wording check | Use upload / choose / select / pick |
| `name: title` with no fallback | Empty title renders blank | `title \|\| "Untitled"` |
| Rendering the object directly: `{metadata}` | React error: objects are not valid children | `JSON.stringify(metadata, null, 2)` |

## Breakdown of the Activity

- **`file`** is a browser `File` (name, size, type, bytes), normally `e.target.files[0]` from a file input.
- **`URL.createObjectURL(file)`** returns a `blob:` address for in-memory data. It is valid only in this tab, and it stays alive until it is revoked.
- **`metadata`** follows the common ERC-721 metadata shape: `name`, `description`, `image`. Marketplaces also read optional `attributes`.
- **The guard clause** keeps the "no file yet" case from ever reaching `createObjectURL`.
