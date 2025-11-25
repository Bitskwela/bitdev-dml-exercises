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
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      // Task 2: Create ContractFactory with artifact
      const factory = new ethers.ContractFactory(
        HelloWorldArtifact.abi,
        HelloWorldArtifact.bytecode,
        signer
      );

      // Task 3: Deploy contract and wait for confirmation
      const contract = await factory.deploy(greet);
      await contract.deployed();
      onDeployed(contract.address);
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
