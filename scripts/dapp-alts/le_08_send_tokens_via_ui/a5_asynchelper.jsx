import { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function transfer(address, uint256) returns (bool)","function decimals() view returns (uint8)"];
async function getToken(address) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  return new ethers.Contract(address, ABI, signer);
}
export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");
  const handleTransfer = async (e) => {
    e.preventDefault();
    if (!ethers.isAddress(recipient)) return setStatus("error");
    if (isNaN(amount) || Number(amount) <= 0) return setStatus("error");
    try {
      setStatus("pending");
      const token = await getToken(contractAddress);
      const tx = await token.transfer(recipient, ethers.parseUnits(amount, await token.decimals()));
      setTxHash(tx.hash);
      await tx.wait();
      setStatus("success");
    } catch { setStatus("error"); }
  };
  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <input placeholder="Recipient Address (0x...)" value={recipient} onChange={(e) => setRecipient(e.target.value)} />
      <input placeholder="Amount" value={amount} onChange={(e) => setAmount(e.target.value)} />
      <button type="submit">Send</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && <p>Transfer successful!</p>}
    </form>
  );
}
