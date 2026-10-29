import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";
export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState(""); const [busy, setBusy] = useState(false); const [error, setError] = useState(""); const [hash, setHash] = useState("");
  const deploy = async () => {
    setBusy(true); setError("");
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = await provider.getSigner();
      const factory = new ethers.ContractFactory(HelloWorldArtifact.abi, HelloWorldArtifact.bytecode, signer);
      const contract = await factory.deploy(greet);
      setHash(contract.deploymentTransaction().hash);
      await contract.waitForDeployment();
      onDeployed(await contract.getAddress());
    } catch (err) { setError(err.message); } finally { setBusy(false); }
  };
  return (<div><input placeholder="Greeting" value={greet} onChange={(e) => setGreet(e.target.value)} />
    <button onClick={deploy} disabled={busy || !greet}>{busy ? "Deploying…" : "Deploy"}</button>{hash && <p>Tx: {hash}</p>}{error && <p>{error}</p>}</div>);
}
