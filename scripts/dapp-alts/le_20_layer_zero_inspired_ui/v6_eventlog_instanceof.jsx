import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function lockTokens() payable returns (uint256)", "event Locked(address indexed user, uint256 amount, uint256 id)"];
export default function LockForm({ onLocked }) {
  const [amt, setAmt] = useState(""); const [step, setStep] = useState("Idle"); const [error, setError] = useState("");
  async function doLock() {
    try {
      setError(""); setStep("Locking");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
      const bridge = new ethers.Contract(process.env.REACT_APP_BRIDGE_ADDR, ABI, signer);
      const tx = await bridge.lockTokens({ value: ethers.parseEther(amt) });
      const receipt = await tx.wait();
      const evt = receipt.logs.find((l) => l instanceof ethers.EventLog && l.eventName === "Locked"); onLocked(Number(evt.args.id), amt);
      setStep("Idle");
    } catch (err) { setError(err.message); setStep("Idle"); }
  }
  const valid = amt && !isNaN(amt) && Number(amt) > 0;
  return (<div><input placeholder="ETH" value={amt} onChange={(e) => setAmt(e.target.value)} disabled={step !== "Idle"} />
    <button onClick={() => setStep("Confirm")} disabled={!valid || step !== "Idle"}>Bridge</button>
    {step === "Confirm" && (<div><p>Lock {amt} ETH on PHChain?</p><button onClick={doLock}>Yes, lock</button><button onClick={() => setStep("Idle")}>Cancel</button></div>)}
    {step === "Locking" && <p>Locking on chain…</p>}{error && <p>{error}</p>}</div>);
}
