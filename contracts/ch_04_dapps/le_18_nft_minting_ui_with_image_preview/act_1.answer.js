import React from "react";

export default function NFTPreview({ title, description, file }) {
  // Task 1: Handle missing file case
  if (!file) {
    return <p>Please upload an image to preview your NFT.</p>;
  }

  // Task 2: Create object URL for image preview
  const imageUrl = URL.createObjectURL(file);

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
}
