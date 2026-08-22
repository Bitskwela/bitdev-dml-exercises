import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";

export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function deploy() {
    try {
      setError("");
      setLoading(true);

      // Task 1: Connect to MetaMask and get signer
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();

      // Task 2: A factory needs both halves of the artifact — the ABI to encode
      // the constructor call, and the bytecode that actually gets deployed.
      const factory = new ethers.ContractFactory(
        HelloWorldArtifact.abi,
        HelloWorldArtifact.bytecode,
        signer
      );

      // Task 3: Deploy contract and wait for confirmation
      const contract = await factory.deploy(greet);
      // Sending the deployment is not the same as it being mined; the address
      // is not usable until this resolves.
      await contract.waitForDeployment();
      onDeployed(await contract.getAddress());
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <h4>Deploy HelloWorld Contract</h4>
      <input
        placeholder="Greeting message"
        value={greet}
        onChange={(e) => setGreet(e.target.value)}
      />
      <button onClick={deploy} disabled={loading || !greet}>
        {loading ? "Deploying…" : "Deploy"}
      </button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
