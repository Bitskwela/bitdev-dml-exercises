import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProfile(address) view returns (string,string,uint256)",
  "function getCredential(address,uint256) view returns (string)",
  "event ProfileUpdated(address indexed user)",
];
const CONTRACT = process.env.REACT_APP_IDENTITY_ADDRESS;

export default function ProfileViewer() {
  const [addr, setAddr] = useState("");
  const [name, setName] = useState("");
  const [status, setStatus] = useState("");
  const [creds, setCreds] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    let identity;

    async function load() {
      try {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        const userAddress = accounts[0];
        setAddr(userAddress);

        const provider = new ethers.providers.Web3Provider(window.ethereum);
        identity = new ethers.Contract(CONTRACT, ABI, provider);

        const [n, s, c] = await identity.getProfile(userAddress);
        setName(n);
        setStatus(s);

        const credCount = c.toNumber();
        const credList = [];
        for (let i = 0; i < credCount; i++) {
          const cred = await identity.getCredential(userAddress, i);
          credList.push(cred);
        }
        setCreds(credList);

        // Listen for profile updates
        identity.on("ProfileUpdated", (user) => {
          if (user.toLowerCase() === userAddress.toLowerCase()) {
            load();
          }
        });
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    load();

    return () => {
      if (identity) {
        identity.removeAllListeners("ProfileUpdated");
      }
    };
  }, []);

  if (loading) return <p>Loading profile…</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Your On-Chain Profile</h3>
      <p>
        <strong>Address:</strong> {addr}
      </p>
      <p>
        <strong>Name:</strong> {name}
      </p>
      <p>
        <strong>Status:</strong> {status}
      </p>
      <h4>Credentials</h4>
      <ul>
        {creds.map((c, i) => (
          <li key={i}>{c}</li>
        ))}
      </ul>
    </div>
  );
}
