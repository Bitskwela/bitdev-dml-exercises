import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getProfile(address) view returns (string,string,uint256)","function getCredential(address,uint256) view returns (string)","event ProfileUpdated(address indexed user)"];
async function getIdentity() {
  const provider = new ethers.BrowserProvider(window.ethereum);
  return new ethers.Contract(process.env.REACT_APP_IDENTITY_ADDRESS, ABI, provider);
}
export default function ProfileViewer() {
  const [profile, setProfile] = useState(null); const [error, setError] = useState("");
  useEffect(() => {
    let identity; let handler;
    async function load() {
      try {
        const [userAddress] = await window.ethereum.request({ method: "eth_requestAccounts" });
        identity = await getIdentity();
        const [name, status, count] = await identity.getProfile(userAddress);
        const creds = await Promise.all(Array.from({ length: Number(count) }, (_, i) => identity.getCredential(userAddress, i)));
        setProfile({ addr: userAddress, name, status, creds });
        handler = (user) => { if (user.toLowerCase() === userAddress.toLowerCase()) load(); };
        identity.on("ProfileUpdated", handler);
      } catch (e) { setError(e.message); }
    }
    load();
    return () => { if (identity) identity.off("ProfileUpdated", handler); };
  }, []);
  if (error) return <p>{error}</p>;
  if (!profile) return <p>Loading profile…</p>;
  return (<div><p>Address: {profile.addr}</p><p>Name: {profile.name}</p><p>Status: {profile.status}</p><ul>{profile.creds.map((c) => <li key={c}>{c}</li>)}</ul></div>);
}
