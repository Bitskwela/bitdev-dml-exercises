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
    let identity;

    async function load() {
      // TODO: Task 1 - Connect the wallet and remember the address
      // TODO: Task 2 - Read getProfile(address); it returns name, status and a
      //                credential count as a tuple
      // TODO: Task 3 - Read getCredential(address, i) for each credential
      // TODO: Task 4 - Subscribe to ProfileUpdated and reload when it is ours
    }

    load();

    // TODO: Task 4 - Return a cleanup that removes the listener
  }, []);

  // TODO: Task 5 - Render loading, error, then the address, name, status and
  //                the credential list
  return <p>Placeholder</p>;
}
