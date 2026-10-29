import { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function transfer(address, uint256) returns (bool)","function decimals() view returns (uint8)"];
export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");
  function handleTransfer(e) {
    e.preventDefault();
    if (!ethers.isAddress(recipient)) return setStatus("error");
    if (isNaN(amount) || Number(amount) <= 0) return setStatus("error");
    setStatus("pending");
    const provider = new ethers.BrowserProvider(window.ethereum);
    return provider.getSigner()
      .then((signer) => new ethers.Contract(contractAddress, ABI, signer))
      .then((c) => c.decimals().then((d) => c.transfer(recipient, ethers.parseUnits(amount, d))))
      .then((tx) => { setTxHash(tx.hash); return tx.wait(); })
      .then(() => setStatus("success"))
      .catch(() => setStatus("error"));
  }
  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <input placeholder="Recipient Address (0x...)" value={recipient} onChange={(e) => setRecipient(e.target.value)} />
      <input placeholder="Amount" value={amount} onChange={(e) => setAmount(e.target.value)} />
      <button type="submit">{status === "pending" ? "Sending..." : "Send"}</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && <p>Transfer successful!</p>}
    </form>
  );
}
