import { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function transfer(address, uint256) returns (bool)","function decimals() view returns (uint8)"];
export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("idle");
  const [txHash, setTxHash] = useState("");
  async function handleTransfer(e) {
    e.preventDefault();
    if (!ethers.isAddress(recipient)) { setStatus("error"); return; }
    if (!(Number(amount) > 0)) { setStatus("error"); return; }
    try {
      setStatus("pending");
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);
      const value = ethers.parseUnits(amount, await token.decimals());
      const tx = await token.transfer(recipient, value);
      setTxHash(tx.hash);
      await tx.wait();
      setStatus("done");
    } catch (err) { setStatus("error"); }
  }
  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <input placeholder="Recipient address (0x...)" value={recipient} onChange={(e) => setRecipient(e.target.value)} />
      <input placeholder="Amount" value={amount} onChange={(e) => setAmount(e.target.value)} />
      <button type="submit">Send</button>
      {txHash && <p>Tx: {txHash}</p>}
      {status === "done" && <p>Transfer complete! Naipadala na.</p>}
      {status === "error" && <p>Something went wrong.</p>}
    </form>
  );
}
