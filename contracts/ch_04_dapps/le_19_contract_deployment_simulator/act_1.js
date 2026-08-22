// DeploySimulator.js - Starter Code
import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";

export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function deploy() {
    // TODO: Task 1 - Connect the wallet and await its signer
    // TODO: Task 2 - Build a ContractFactory from the artifact's abi + bytecode
    // TODO: Task 3 - Deploy with the greeting, wait for the deployment to be
    //                mined, then hand the address to onDeployed()
  }

  return (
    <div>
      <h4>Deploy HelloWorld Contract</h4>
      {/* TODO: Task 4 - Greeting input, a Deploy button that is disabled while
          deploying or empty, and the error state */}
      <p>Placeholder</p>
    </div>
  );
}
