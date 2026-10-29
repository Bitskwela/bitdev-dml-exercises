import { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function transfer(address, uint256) returns (bool)","function decimals() view returns (uint8)"];
export default function TokenTransfer({ contractAddress }) {
  const [form, setForm] = useState({ to: "", amount: "" });
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");
  const handleTransfer = async (e) => {
    e.preventDefault();
    if (!ethers.isAddress(form.to) || !(Number(form.amount) > 0)) { setStatus("error"); return; }
    try {
      setStatus("pending");
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, ABI, signer);
      const tx = await contract.transfer(form.to, ethers.parseUnits(form.amount, await contract.decimals()));
      setTxHash(tx.hash);
      await tx.wait();
      setStatus("success");
    } catch { setStatus("error"); }
  };
  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <label>Recipient <input placeholder="0x..." value={form.to} onChange={(e) => setForm({ ...form, to: e.target.value })} /></label>
      <label>Amount <input placeholder="e.g. 2.5" value={form.amount} onChange={(e) => setForm({ ...form, amount: e.target.value })} /></label>
      <button type="submit">Send</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && <p>Transfer successful!</p>}
    </form>
  );
}
