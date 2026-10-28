// ProfileViewer.js - Starter Code
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
    if (!window.ethereum) {
      setError("Please install MetaMask to view your profile.");
      setLoading(false);
      return;
    }

    // One provider, one contract and one listener for the life of the effect.
    // load() only reads, so reloading on an event never adds another listener.
    const provider = new ethers.BrowserProvider(window.ethereum);
    const identity = new ethers.Contract(CONTRACT, ABI, provider);
    let userAddress = "";

    async function load() {
      try {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        userAddress = accounts[0];
        setAddr(userAddress);

        const [n, s, c] = await identity.getProfile(userAddress);
        setName(n);
        setStatus(s);

        const credCount = Number(c);
        const credList = [];
        for (let i = 0; i < credCount; i++) {
          const cred = await identity.getCredential(userAddress, i);
          credList.push(cred);
        }
        setCreds(credList);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    // Task 4: subscribe once, here, not inside load() — subscribing inside it
    // would add a listener on every reload, and each one reloads again.
    function handleProfileUpdated(user) {
      if (userAddress && user.toLowerCase() === userAddress.toLowerCase()) {
        load();
      }
    }
    identity.on("ProfileUpdated", handleProfileUpdated);

    load();

    return () => {
      identity.off("ProfileUpdated", handleProfileUpdated);
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
