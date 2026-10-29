import React, { useMemo, useEffect } from "react";
export default function NFTPreview({ title, description, file }) {
  const imageUrl = useMemo(() => (file ? URL.createObjectURL(file) : null), [file]);
  useEffect(() => () => { if (imageUrl) URL.revokeObjectURL(imageUrl); }, [imageUrl]);
  if (!file) return <p>Choose an image to preview your NFT.</p>;
  const metadata = { name: title || "Untitled", description: description || "", image: imageUrl };
  return (<div><img src={imageUrl} alt="preview" /><h4>{metadata.name}</h4><p>{metadata.description}</p><pre>{JSON.stringify(metadata, null, 2)}</pre></div>);
}
