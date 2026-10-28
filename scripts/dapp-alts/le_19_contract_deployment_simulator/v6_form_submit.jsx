import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";
export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState(""); const [loading, setLoading] = useState(false); const [error, setError] = useState("");
  async function handleSubmit(e) {
    e.preventDefault();
    setLoading(true); setError("");
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
      const factory = new ethers.ContractFactory(HelloWorldArtifact.abi, HelloWorldArtifact.bytecode, signer);
      const contract = await factory.deploy(greet);
      await contract.waitForDeployment();
      onDeployed(contract.target);
    } catch (err) { setError(err.message); } finally { setLoading(false); }
  }
  return (<form onSubmit={handleSubmit}><input placeholder="Greeting message" value={greet} onChange={(e) => setGreet(e.target.value)} />
    <button type="submit" disabled={loading || !greet.trim()}>{loading ? "Deploying…" : "Deploy"}</button>{error && <p>{error}</p>}</form>);
}
