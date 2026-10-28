import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getProfile(address) view returns (string,string,uint256)","function getCredential(address,uint256) view returns (string)","event ProfileUpdated(address indexed user)"];
const CONTRACT = process.env.REACT_APP_IDENTITY_ADDRESS;
export default function ProfileViewer() {
  const [addr, setAddr] = useState(""); const [p, setP] = useState(null); const [error, setError] = useState(""); const [tick, setTick] = useState(0);
  useEffect(() => { window.ethereum.request({ method: "eth_requestAccounts" }).then((a) => setAddr(a[0])).catch((e) => setError(e.message)); }, []);
  useEffect(() => {
    if (!addr) return;
    const identity = new ethers.Contract(CONTRACT, ABI, new ethers.BrowserProvider(window.ethereum));
    (async () => {
      try {
        const res = await identity.getProfile(addr);
        const credCount = Number(res[2]);
        const creds = [];
        for (let i = 0; i < credCount; i++) creds.push(await identity.getCredential(addr, i));
        setP({ name: res[0], status: res[1], creds });
      } catch (e) { setError(e.message); }
    })();
    const onUpdate = (user) => { if (user.toLowerCase() === addr.toLowerCase()) setTick((t) => t + 1); };
    identity.on("ProfileUpdated", onUpdate);
    return () => identity.off("ProfileUpdated", onUpdate);
  }, [addr, tick]);
  if (error) return <p>{error}</p>;
  if (!p) return <p>Loading…</p>;
  return (<div><p>{addr}</p><p>{p.name} — {p.status}</p><ul>{p.creds.map((c, i) => <li key={i}>{c}</li>)}</ul></div>);
}
