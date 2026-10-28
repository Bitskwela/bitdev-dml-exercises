import React, { useState, useEffect } from "react";
export default function NFTPreview({ title, description, file }) {
  const [preview, setPreview] = useState("");
  useEffect(() => {
    if (!file) return;
    const url = URL.createObjectURL(file);
    setPreview(url);
    return () => URL.revokeObjectURL(url);
  }, [file]);
  if (!file) return <p>Please select an image first.</p>;
  const metadata = { name: title || "Untitled", description: description || "", image: preview };
  return (<div>{preview && <img src={preview} alt="NFT" />}<h4>{metadata.name}</h4><p>{metadata.description}</p><pre>{JSON.stringify(metadata, null, 2)}</pre></div>);
}
