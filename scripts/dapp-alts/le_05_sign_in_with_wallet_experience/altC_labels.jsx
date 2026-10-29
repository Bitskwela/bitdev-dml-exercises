import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/Authenticator.json";
export default function WalletAuth() {
  const [account, setAccount] = useState(null);
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [ok, setOk] = useState(false);
  const [error, setError] = useState("");
  const connectWallet = async () => {
    if (!window.ethereum) return setError("Please install MetaMask!");
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    setAccount(await signer.getAddress());
  };
  const signMessage = async () => {
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    const msg = `Sign in to Dashboard\n\nNonce: ${Date.now()}`;
    setSignature(await signer.signMessage(msg));
    setMessage(msg);
  };
  const verifySignature = async () => {
    const { v, r, s } = ethers.Signature.from(signature);
    const c = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL));
    if (await c.verify(account, ethers.id(message), v, r, s)) setOk(true); else setError("failed");
  };
  return (
    <div>
      {!account ? <button onClick={connectWallet}>Connect MetaMask</button>
        : !signature ? <div><p>Connected: {account}</p><button onClick={signMessage}>Sign Message</button></div>
        : !ok ? <button onClick={verifySignature}>Verify Signature</button>
        : <h2>Welcome to the Dashboard!</h2>}
      {error && <p>{error}</p>}
    </div>
  );
}
