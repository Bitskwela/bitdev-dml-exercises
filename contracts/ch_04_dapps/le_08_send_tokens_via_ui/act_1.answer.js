import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function transfer(address, uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");

  const handleTransfer = async (e) => {
    e.preventDefault();

    // Validate inputs
    if (!ethers.utils.isAddress(recipient)) {
      setStatus("error");
      alert("Invalid recipient address");
      return;
    }

    if (!amount || isNaN(amount) || Number(amount) <= 0) {
      setStatus("error");
      alert("Enter a valid positive amount");
      return;
    }

    try {
      setStatus("pending");
      setTxHash("");

      // Connect wallet and get signer
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(contractAddress, ABI, signer);

      // Parse amount with decimals and transfer
      const decimals = await contract.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      setTxHash(tx.hash);

      await tx.wait();
      setStatus("success");

      // Clear form
      setRecipient("");
      setAmount("");
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus("error");
    }
  };

  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <input
        placeholder="Recipient Address (0x...)"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
      />
      <input
        placeholder="Amount"
        type="number"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button type="submit" disabled={status === "pending"}>
        {status === "pending" ? "Sending..." : "Send"}
      </button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && (
        <p style={{ color: "green" }}>✅ Transfer successful!</p>
      )}
      {status === "error" && <p style={{ color: "red" }}>❌ Transfer failed</p>}
    </form>
  );
}
