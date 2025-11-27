# NFT Image Preview Component Activity

## Initial Code

```js
// NFTPreview.js - Starter Code
import React from "react";

export default function NFTPreview({ title, description, file }) {
  // TODO: Task 1 - Handle missing file case
  // @note Check if the file prop is falsy and return a prompt message if not provided

  // TODO: Task 2 - Create object URL for image preview
  // @note Use URL.createObjectURL() to generate a temporary blob URL for the uploaded file

  // TODO: Task 3 - Build metadata object and render preview UI
  // @note Construct metadata following NFT standard, then render image preview and JSON

  return <div>{/* Your preview UI here */}</div>;
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: File input validation, `URL.createObjectURL()`, NFT metadata structure, `JSON.stringify()` formatting, Conditional rendering

---

### Task 1: Handle Missing File Case

Check if the `file` prop is falsy (undefined, null, or not provided). If no file exists, return an early message prompting the user to upload an image. This prevents errors when trying to create an object URL from undefined.

```js
if (!file) {
  return <p>Please upload an image to preview your NFT.</p>;
}
```

---

### Task 2: Create Object URL for Image Preview

Use `URL.createObjectURL(file)` to generate a temporary blob URL for the uploaded File object. This URL can be used directly as the `src` attribute for an `<img>` element to display the image preview without uploading to a server.

```js
const imageUrl = URL.createObjectURL(file);
```

---

### Task 3: Build Metadata Object and Render Preview UI

Construct a metadata object following the NFT metadata standard with `name`, `description`, and `image` fields. Use fallback values for empty inputs. Display the formatted JSON using `JSON.stringify()` with 2-space indentation inside a `<pre>` tag.

```js
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

---

## Breakdown of the Activity

**Variables Defined:**

- `title`: The NFT name passed as a prop from the parent component. Falls back to "Untitled" if empty or not provided.

- `description`: The NFT description passed as a prop. Used to describe the NFT's content or story. Falls back to empty string if not provided.

- `file`: A JavaScript `File` object from an `<input type="file">` element. Contains the uploaded image data including name, size, type, and binary content.

- `imageUrl`: A temporary blob URL created by `URL.createObjectURL()`. This URL is only valid for the current browser session and allows displaying the image without uploading to a server first.

- `metadata`: An object following the NFT metadata standard (ERC-721 metadata schema). Contains `name`, `description`, and `image` fields that would typically be stored on IPFS and linked via tokenURI.

**Key Functions:**

- `URL.createObjectURL(file)`:
  Creates a temporary URL representing the File object. The URL starts with `blob:` and points to the file data in memory. This allows previewing images client-side without server uploads. The URL is automatically revoked when the document is unloaded, but can be manually revoked with `URL.revokeObjectURL()` for memory optimization.

- `JSON.stringify(metadata, null, 2)`:
  Converts the metadata object to a formatted JSON string. The second argument (`null`) is a replacer function (not used here). The third argument (`2`) specifies the number of spaces for indentation, making the output human-readable. Essential for showing users what their NFT metadata will look like.

- Conditional early return:
  The pattern `if (!file) return <p>...</p>` is a guard clause that handles the edge case before the main logic. This prevents `URL.createObjectURL(undefined)` which would throw an error.
