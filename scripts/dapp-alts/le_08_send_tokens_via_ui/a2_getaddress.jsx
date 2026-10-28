import { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function transfer(address, uint256) returns (bool)","function decimals() view returns (uint8)"];
export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");
  const handleTransfer = async (e) => {
    e.preventDefault();
    let to;
    try { to = ethers.getAddress(recipient); } catch { setStatus("error"); alert("Invalid recipient address"); return; }
    if (!amount || Number(amount) <= 0) { setStatus("error"); return; }
    try {
      setStatus("pending");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, ABI, signer);
      const decimals = await contract.decimals();
      const tx = await contract.transfer(to, ethers.parseUnits(amount, decimals));
      setTxHash(tx.hash);
      await tx.wait();
      setStatus("success");
    } catch (err) { setStatus("error"); }
  };
  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <input placeholder="Recipient Address (0x...)" value={recipient} onChange={(e) => setRecipient(e.target.value)} />
      <input placeholder="Amount" type="number" value={amount} onChange={(e) => setAmount(e.target.value)} />
      <button type="submit" disabled={status === "pending"}>Send</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && <p>Transfer successful!</p>}
      {status === "error" && <p>Transfer failed</p>}
    </form>
  );
}
