// NFTReader.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NFTReader() {
  const [info, setInfo] = useState({ name: "", symbol: "", total: 0 });
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");

  useEffect(() => {
    // TODO: Task 1 - Read name(), symbol() and totalMinted() from the contract
    // @note Build a read-only JsonRpcProvider, then an ethers.Contract, then
    //       store the three values in `info`. totalMinted() returns a bigint.
  }, []);

  const fetchTokenURI = async () => {
    // TODO: Task 2 - Read tokenURIs(tokenId) and store it in `uri`
  };

  return (
    <div>
      {/* TODO: Task 3 - Show the name, symbol, total, and the fetched URI */}
      <p>Placeholder</p>
    </div>
  );
}
