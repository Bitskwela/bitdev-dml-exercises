import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";
// Control (wrong): v6 factory, but v5 contract.deployed() and contract.address. Real v6: deployed is not a function.
export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState(""); const [busy, setBusy] = useState(false); const [error, setError] = useState("");
  const deploy = async () => {
    setBusy(true);
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
      const { abi, bytecode } = HelloWorldArtifact;
      const contract = await new ethers.ContractFactory(abi, bytecode, signer).deploy(greet);
      await contract.deployed();
      onDeployed(contract.address);
    } catch (err) { setError(err.message); } finally { setBusy(false); }
  };
  return (<div><input value={greet} onChange={(e) => setGreet(e.target.value)} />
    <button onClick={deploy} disabled={busy || greet.trim() === ""}>Deploy contract</button>{error && <p>{error}</p>}</div>);
}
