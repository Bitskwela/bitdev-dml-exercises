# Answer Keys

This file contains the answer keys for the exercises in Chapter 4: DApps.

## Lesson 1: Connect my Metamask

### Activity 1: MetaMask Detection

**Solution for DetectWallet.js:**

```js
export default function DetectWallet() {
  const hasWallet = Boolean(window.ethereum);
  return (
    <div>
      {hasWallet ? (
        <p>Wallet detected! 🦊</p>
      ) : (
        <p>Please install MetaMask to continue.</p>
      )}
    </div>
  );
}
```

### Activity 2: Connect & Display Account

**Solution for ConnectButton.js:**

```js
import { useState } from "react";

export default function ConnectButton() {
  const [acct, setAcct] = useState(null);

  const connect = async () => {
    if (!window.ethereum) return alert("Install MetaMask!");
    const [addr] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    setAcct(addr);
  };

  return (
    <div>
      {acct ? (
        <p>Account: {acct}</p>
      ) : (
        <button onClick={connect}>Connect</button>
      )}
    </div>
  );
}
```

### Activity 3: Listen to Account & Network Changes

**Solution for LiveConnector.js:**

```js
import { useState, useEffect } from "react";

export default function LiveConnector() {
  const [acct, setAcct] = useState(null);
  const [chain, setChain] = useState(null);

  useEffect(() => {
    if (!window.ethereum) return;

    const onAccountsChanged = (accounts) => {
      setAcct(accounts[0] || null);
    };

    const onChainChanged = (chainHex) => {
      setChain(chainHex);
    };

    window.ethereum.on("accountsChanged", onAccountsChanged);
    window.ethereum.on("chainChanged", onChainChanged);

    return () => {
      window.ethereum.removeListener("accountsChanged", onAccountsChanged);
      window.ethereum.removeListener("chainChanged", onChainChanged);
    };
  }, []);

  const connect = async () => {
    if (!window.ethereum) return alert("Install MetaMask!");
    const [addr] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    setAcct(addr);
    const hex = await window.ethereum.request({ method: "eth_chainId" });
    setChain(hex);
  };

  return (
    <div>
      {acct ? (
        <div>
          <p>Account: {acct}</p>
          <p>Network: {chain}</p>
        </div>
      ) : (
        <button onClick={connect}>Connect MetaMask 🦊</button>
      )}
    </div>
  );
}
```

## Lesson 2: Read Smart Contract Data

### Activity 1: Name & Symbol Reader

**Solution for NameSymbol.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NameSymbol() {
  const [info, setInfo] = useState({ name: "", symbol: "" });

  useEffect(() => {
    async function fetchInfo() {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );
      const [n, s] = await Promise.all([contract.name(), contract.symbol()]);
      setInfo({ name: n, symbol: s });
    }
    fetchInfo();
  }, []);

  return (
    <div>
      <h1>{info.name || "Loading..."}</h1>
      <h3>{info.symbol || "Loading..."}</h3>
    </div>
  );
}
```

### Activity 2: Total Minted Counter

**Solution for TotalMinted.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function TotalMinted() {
  const [total, setTotal] = useState(null);

  useEffect(() => {
    async function loadTotal() {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );
      const bn = await contract.totalMinted();
      setTotal(bn.toNumber());
    }
    loadTotal();
  }, []);

  return <p>Total Minted: {total ?? "Loading..."}</p>;
}
```

### Activity 3: Token URI Lookup

**Solution for TokenURI.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function TokenURI() {
  const [id, setId] = useState(0);
  const [uri, setUri] = useState("");

  const fetchUri = async () => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );
    try {
      const result = await contract.tokenURIs(id);
      setUri(result);
    } catch (err) {
      alert("Invalid ID or RPC error");
    }
  };

  return (
    <div>
      <input
        type="number"
        value={id}
        onChange={(e) => setId(+e.target.value)}
      />
      <button onClick={fetchUri}>Fetch URI</button>
      {uri && <p>{uri}</p>}
    </div>
  );
}
```

## Lesson 3: Triggering a Function

### Activity 1: Display Vote Counts

**Solution for VoteCounts.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function VoteCounts({ proposals }) {
  const [counts, setCounts] = useState({});

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    async function loadCounts() {
      const result = {};
      for (const p of proposals) {
        const bn = await contract.getVoteCount(p);
        result[p] = bn.toNumber();
      }
      setCounts(result);
    }
    loadCounts();
  }, [proposals]);

  return (
    <ul>
      {proposals.map((p) => (
        <li key={p}>
          {p}: {counts[p] ?? "..."}
        </li>
      ))}
    </ul>
  );
}
```

### Activity 2: Cast Vote Transaction

**Solution for CastVote.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    if (!window.ethereum) {
      alert("Please install MetaMask");
      return;
    }
    try {
      setStatus("pending");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = web3Provider.getSigner();
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );
      const tx = await contract.vote(selected, { gasLimit: 100_000 });
      console.log("Tx Hash:", tx.hash);
      await tx.wait();
      setStatus("confirmed ✅");
      onVoted();
    } catch (err) {
      console.error(err);
      setStatus("error: " + (err.data?.message || err.message));
    }
  };

  return (
    <div>
      <select onChange={(e) => setSelected(e.target.value)}>
        {proposals.map((p) => (
          <option key={p}>{p}</option>
        ))}
      </select>
      <button onClick={castVote} disabled={status === "pending"}>
        {status === "pending" ? "Voting…" : "Vote"}
      </button>
      {status && <p>{status}</p>}
    </div>
  );
}
```

### Activity 3: Auto-Refresh on Voted Events

**Solution for VoteApp.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";
import VoteCounts from "./VoteCounts";
import CastVote from "./CastVote";

export default function VoteApp({ proposals }) {
  const [refreshKey, setRefreshKey] = useState(0);
  const refresh = () => setRefreshKey((k) => k + 1);

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const handler = (voter, proposal) => {
      console.log(`Event: ${voter} voted ${proposal}`);
      refresh();
    };

    contract.on("Voted", handler);

    return () => {
      contract.off("Voted", handler);
    };
  }, []);

  return (
    <div>
      <VoteCounts key={refreshKey} proposals={proposals} />
      <CastVote proposals={proposals} onVoted={refresh} />
    </div>
  );
}
```

## Lesson 4: Event Listeners in the Frontend

### Activity 1: Basic Event Listener

**Solution for RaffleListener.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const handleWinnerPicked = (winnerAddress) => {
      setWinner(winnerAddress);
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);

  return (
    <div>
      <h2>Latest Winner:</h2>
      <p>{winner || "..."}</p>
    </div>
  );
}
```

### Activity 2: Winner History Tracker

**Solution for WinnerHistory.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function WinnerHistory() {
  const [winners, setWinners] = useState([]);

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const handleWinnerPicked = (winnerAddress) => {
      setWinners((prev) => [...prev, winnerAddress]);
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);

  return (
    <div>
      <h2>Winner History:</h2>
      <ul>
        {winners.map((winner, idx) => (
          <li key={idx}>
            #{idx + 1}: {winner}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

### Activity 3: Fetch Past Winners

**Solution for PastWinners.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function PastWinners() {
  const [pastWinners, setPastWinners] = useState([]);
  const [newWinners, setNewWinners] = useState([]);

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    // Fetch past events
    const loadPastWinners = async () => {
      const filter = contract.filters.WinnerPicked();
      const events = await contract.queryFilter(filter);
      const winners = events.map((event) => event.args.winner);
      setPastWinners(winners);
    };

    // Listen for new events
    const handleNewWinner = (winnerAddress) => {
      setNewWinners((prev) => [...prev, winnerAddress]);
    };

    loadPastWinners();
    contract.on("WinnerPicked", handleNewWinner);

    return () => {
      contract.off("WinnerPicked", handleNewWinner);
    };
  }, []);

  const allWinners = [...pastWinners, ...newWinners];

  return (
    <div>
      <h2>All Winners (Past + Live):</h2>
      <ul>
        {allWinners.map((winner, idx) => (
          <li key={idx}>
            #{idx + 1}: {winner} {idx >= pastWinners.length ? "🔴 LIVE" : ""}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

## Lesson 5: Sign in with Wallet Experience

### Activity 1: Connect Wallet & Display Address

**Solution for WalletConnect.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";

export default function WalletConnect() {
  const [account, setAccount] = useState(null);
  const [error, setError] = useState("");

  const connectWallet = async () => {
    try {
      setError("");
      if (!window.ethereum) {
        setError("Please install MetaMask!");
        return;
      }

      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });

      setAccount(accounts[0]);
    } catch (err) {
      console.error("Connection failed:", err);
      setError("Failed to connect wallet");
    }
  };

  return (
    <div>
      {account ? (
        <div>
          <p>Connected: {account}</p>
          <button onClick={() => setAccount(null)}>Disconnect</button>
        </div>
      ) : (
        <button onClick={connectWallet}>Connect Wallet</button>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

### Activity 2: Sign Nonce Message

**Solution for MessageSigner.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";

export default function MessageSigner() {
  const [account, setAccount] = useState("");
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [nonce, setNonce] = useState("");

  const generateNonce = () => {
    const randomNonce = Math.random().toString(36).substring(2);
    setNonce(randomNonce);
    setMessage(`Sign in to our DApp. Nonce: ${randomNonce}`);
  };

  const signMessage = async () => {
    try {
      if (!window.ethereum) {
        alert("Please install MetaMask!");
        return;
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const signature = await signer.signMessage(message);
      const address = await signer.getAddress();

      setSignature(signature);
      setAccount(address);
    } catch (err) {
      console.error("Signing failed:", err);
      alert("Failed to sign message");
    }
  };

  return (
    <div>
      <button onClick={generateNonce}>Generate Nonce</button>
      {message && (
        <div>
          <p>Message to sign: {message}</p>
          <button onClick={signMessage}>Sign Message</button>
        </div>
      )}
      {signature && (
        <div>
          <p>Signature: {signature}</p>
          <p>Signer: {account}</p>
        </div>
      )}
    </div>
  );
}
```

### Activity 3: Verify Signature On-Chain

**Solution for SignatureVerifier.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/SignatureVerifier.json";

export default function SignatureVerifier() {
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [signer, setSigner] = useState("");
  const [isValid, setIsValid] = useState(null);

  const verifyOnChain = async () => {
    try {
      if (!message || !signature || !signer) {
        alert("Please fill all fields");
        return;
      }

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_VERIFIER_ADDRESS,
        abi,
        provider
      );

      const result = await contract.verifySignature(message, signature, signer);
      setIsValid(result);
    } catch (err) {
      console.error("Verification failed:", err);
      alert("Verification failed");
      setIsValid(false);
    }
  };

  return (
    <div>
      <input
        placeholder="Message"
        value={message}
        onChange={(e) => setMessage(e.target.value)}
      />
      <input
        placeholder="Signature"
        value={signature}
        onChange={(e) => setSignature(e.target.value)}
      />
      <input
        placeholder="Expected Signer Address"
        value={signer}
        onChange={(e) => setSigner(e.target.value)}
      />
      <button onClick={verifyOnChain}>Verify Signature</button>
    </div>
  );
}
```

## Lesson 6: Token Tracker

### Activity 1: Token Info Display

**Solution for TokenInfo.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenInfo({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });

  useEffect(() => {
    const fetchTokenInfo = async () => {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, abi, provider);

      const [name, symbol, decimals] = await Promise.all([
        contract.name(),
        contract.symbol(),
        contract.decimals(),
      ]);

      setInfo({ name, symbol, decimals });
    };

    if (tokenAddress) {
      fetchTokenInfo();
    }
  }, [tokenAddress]);

  return (
    <div>
      <h2>Token Information</h2>
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
    </div>
  );
}
```

### Activity 2: Wallet Token Balance

**Solution for TokenBalance.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenBalance({ tokenAddress, walletAddress }) {
  const [balance, setBalance] = useState("0");
  const [decimals, setDecimals] = useState(18);

  useEffect(() => {
    const fetchBalance = async () => {
      if (!tokenAddress || !walletAddress) return;

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, abi, provider);

      const [balanceRaw, decimalsValue] = await Promise.all([
        contract.balanceOf(walletAddress),
        contract.decimals(),
      ]);

      setBalance(balanceRaw.toString());
      setDecimals(decimalsValue);
    };

    fetchBalance();
  }, [tokenAddress, walletAddress]);

  const formatBalance = (raw, decimals) => {
    return ethers.utils.formatUnits(raw, decimals);
  };

  return (
    <div>
      <h3>Your Balance</h3>
      <p>{formatBalance(balance, decimals)} tokens</p>
    </div>
  );
}
```

### Activity 3: Token Transfer Form

**Solution for TokenTransfer.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenTransfer({ tokenAddress, onTransferComplete }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");

  const handleTransfer = async (e) => {
    e.preventDefault();
    try {
      setStatus("pending");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(tokenAddress, abi, signer);
      const decimals = await contract.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      await tx.wait();

      setStatus("✅ Transfer successful!");
      setRecipient("");
      setAmount("");

      if (onTransferComplete) {
        onTransferComplete();
      }
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleTransfer}>
      <h3>Transfer Tokens</h3>
      <input
        placeholder="Recipient Address"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
        required
      />
      <input
        type="number"
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        required
      />
      <button type="submit" disabled={status === "pending"}>
        {status === "pending" ? "Sending..." : "Send Tokens"}
      </button>
    </form>
  );
}
```

## Lesson 7: Sining Chain (NFT Collection)

### Activity 1: Single NFT Renderer

**Solution for NFTViewer.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/NFT.json";

export default function NFTViewer({ tokenId }) {
  const [nft, setNft] = useState({ name: "", image: "", description: "" });
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchNFTMetadata = async () => {
      if (!tokenId) return;

      setLoading(true);
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        const tokenURI = await contract.tokenURI(tokenId);
        const response = await fetch(tokenURI);
        const metadata = await response.json();

        setNft({
          name: metadata.name || `NFT #${tokenId}`,
          image: metadata.image || "",
          description: metadata.description || "",
        });
      } catch (err) {
        console.error("Failed to fetch NFT metadata:", err);
        setNft({
          name: `NFT #${tokenId}`,
          image: "",
          description: "Failed to load",
        });
      } finally {
        setLoading(false);
      }
    };

    fetchNFTMetadata();
  }, [tokenId]);

  return (
    <div>
      <h3>NFT #{tokenId}</h3>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <div>
          <h4>{nft.name}</h4>
          <img src={nft.image} alt={nft.name} style={{ maxWidth: "200px" }} />
          <p>{nft.description}</p>
        </div>
      )}
    </div>
  );
}
```

### Activity 2: Wallet NFT Collection

**Solution for WalletNFTs.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/NFT.json";

export default function WalletNFTs({ walletAddress }) {
  const [ownedTokens, setOwnedTokens] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchOwnedNFTs = async () => {
      if (!walletAddress) return;

      setLoading(true);
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        const balance = await contract.balanceOf(walletAddress);
        const totalSupply = await contract.totalSupply();

        const owned = [];
        for (let i = 0; i < totalSupply.toNumber(); i++) {
          try {
            const owner = await contract.ownerOf(i);
            if (owner.toLowerCase() === walletAddress.toLowerCase()) {
              owned.push(i);
            }
          } catch (err) {
            // Token might not exist, skip
          }
        }

        setOwnedTokens(owned);
      } catch (err) {
        console.error("Failed to fetch owned NFTs:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchOwnedNFTs();
  }, [walletAddress]);

  return (
    <div>
      <h3>Your NFTs</h3>
      {loading ? (
        <p>Loading collection...</p>
      ) : (
        <div>
          {ownedTokens.map((tokenId) => (
            <div key={tokenId}>Token #{tokenId}</div>
          ))}
        </div>
      )}
    </div>
  );
}
```

### Activity 3: All Minted NFTs Display

**Solution for AllNFTs.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/NFT.json";

export default function AllNFTs() {
  const [totalSupply, setTotalSupply] = useState(0);
  const [allTokens, setAllTokens] = useState([]);

  useEffect(() => {
    const fetchAllNFTs = async () => {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        const supply = await contract.totalSupply();
        setTotalSupply(supply.toNumber());

        const tokens = [];
        for (let i = 0; i < supply.toNumber(); i++) {
          tokens.push(i);
        }
        setAllTokens(tokens);
      } catch (err) {
        console.error("Failed to fetch NFTs:", err);
      }
    };

    fetchAllNFTs();
  }, []);

  return (
    <div>
      <h3>All Minted NFTs (Total: {totalSupply})</h3>
      <div>
        {allTokens.map((tokenId) => (
          <div key={tokenId}>
            Token #{tokenId}
            {/* Could integrate with NFTViewer component */}
          </div>
        ))}
      </div>
    </div>
  );
}
```

## Lesson 8: Send Tokens via UI

### Activity 1: Basic Token Transfer Form

**Solution for TokenTransferForm.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenTransferForm() {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setStatus("Processing...");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const decimals = await contract.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Transfer successful!");

      setRecipient("");
      setAmount("");
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Send Tokens</h3>
      <input
        placeholder="Recipient Address"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
        required
      />
      <input
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        required
      />
      <button type="submit">Send</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

### Activity 2: Transfer with Balance Check

**Solution for SafeTransferForm.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function SafeTransferForm() {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [balance, setBalance] = useState("0");
  const [status, setStatus] = useState("");
  const [account, setAccount] = useState("");

  useEffect(() => {
    const loadBalance = async () => {
      if (!window.ethereum) return;

      try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const accounts = await provider.send("eth_requestAccounts", []);
        setAccount(accounts[0]);

        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        const balance = await contract.balanceOf(accounts[0]);
        const decimals = await contract.decimals();
        setBalance(ethers.utils.formatUnits(balance, decimals));
      } catch (err) {
        console.error("Failed to load balance:", err);
      }
    };

    loadBalance();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (parseFloat(amount) > parseFloat(balance)) {
        setStatus("❌ Insufficient balance");
        return;
      }

      setStatus("Processing...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const decimals = await contract.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Transfer successful!");

      setRecipient("");
      setAmount("");

      // Reload balance
      const newBalance = await contract.balanceOf(account);
      setBalance(ethers.utils.formatUnits(newBalance, decimals));
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Send Tokens</h3>
      <p>Your Balance: {balance} tokens</p>
      <input
        placeholder="Recipient Address"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
        required
      />
      <input
        type="number"
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        max={balance}
        required
      />
      <button type="submit">Send</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

### Activity 3: Transfer with Transaction History

**Solution for TransferWithHistory.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TransferWithHistory() {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [history, setHistory] = useState([]);
  const [account, setAccount] = useState("");

  useEffect(() => {
    const loadTransferHistory = async () => {
      if (!window.ethereum) return;

      try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const accounts = await provider.send("eth_requestAccounts", []);
        setAccount(accounts[0]);

        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        // Get transfer events where user is sender
        const filter = contract.filters.Transfer(accounts[0]);
        const events = await contract.queryFilter(filter);

        const transfers = events.map((event) => ({
          to: event.args.to,
          amount: ethers.utils.formatUnits(event.args.value, 18),
          txHash: event.transactionHash,
          blockNumber: event.blockNumber,
        }));

        setHistory(transfers);
      } catch (err) {
        console.error("Failed to load history:", err);
      }
    };

    loadTransferHistory();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setStatus("Processing...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const decimals = await contract.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Transfer successful!");

      // Add to history
      setHistory((prev) => [
        ...prev,
        {
          to: recipient,
          amount: amount,
          txHash: tx.hash,
          blockNumber: "pending",
        },
      ]);

      setRecipient("");
      setAmount("");
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <h3>Send Tokens</h3>
        <input
          placeholder="Recipient Address"
          value={recipient}
          onChange={(e) => setRecipient(e.target.value)}
          required
        />
        <input
          placeholder="Amount"
          value={amount}
          onChange={(e) => setAmount(e.target.value)}
          required
        />
        <button type="submit">Send</button>
        {status && <p>{status}</p>}
      </form>

      <div>
        <h4>Transfer History</h4>
        {history.map((transfer, idx) => (
          <div key={idx}>
            <p>To: {transfer.to}</p>
            <p>Amount: {transfer.amount} tokens</p>
            <p>Tx: {transfer.txHash}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
```

## Lesson 9: OnChain To-Do List

### Activity 1: List All Tasks

**Solution for TaskList.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/TodoContract.json";

export default function TaskList() {
  const [tasks, setTasks] = useState([]);

  useEffect(() => {
    const fetchTasks = async () => {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        const taskCount = await contract.taskCount();
        const allTasks = [];

        for (let i = 0; i < taskCount.toNumber(); i++) {
          const task = await contract.tasks(i);
          allTasks.push({
            id: i,
            text: task.text,
            completed: task.completed,
          });
        }

        setTasks(allTasks);
      } catch (err) {
        console.error("Failed to fetch tasks:", err);
      }
    };

    fetchTasks();
  }, []);

  return (
    <div>
      <h3>Your Tasks</h3>
      <ul>
        {tasks.map((task) => (
          <li key={task.id}>
            <input type="checkbox" checked={task.completed} readOnly />
            {task.text}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

### Activity 2: Add New Task

**Solution for AddTask.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/TodoContract.json";

export default function AddTask({ onTaskAdded }) {
  const [taskText, setTaskText] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!taskText.trim()) return;

    try {
      setStatus("Adding task...");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const tx = await contract.addTask(taskText);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Task added!");

      setTaskText("");

      if (onTaskAdded) {
        onTaskAdded();
      }
    } catch (err) {
      console.error("Failed to add task:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Add New Task</h3>
      <input
        placeholder="Enter task description"
        value={taskText}
        onChange={(e) => setTaskText(e.target.value)}
        required
      />
      <button type="submit">Add Task</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

### Activity 3: Toggle Task Completion

**Solution for TodoApp.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/TodoContract.json";

export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTaskText, setNewTaskText] = useState("");
  const [status, setStatus] = useState("");

  const loadTasks = async () => {
    try {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      const taskCount = await contract.taskCount();
      const allTasks = [];

      for (let i = 0; i < taskCount.toNumber(); i++) {
        const task = await contract.tasks(i);
        allTasks.push({
          id: i,
          text: task.text,
          completed: task.completed,
        });
      }

      setTasks(allTasks);
    } catch (err) {
      console.error("Failed to fetch tasks:", err);
    }
  };

  useEffect(() => {
    loadTasks();
  }, []);

  const addTask = async (e) => {
    e.preventDefault();
    if (!newTaskText.trim()) return;

    try {
      setStatus("Adding task...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const tx = await contract.addTask(newTaskText);
      await tx.wait();

      setStatus("✅ Task added!");
      setNewTaskText("");
      loadTasks();
    } catch (err) {
      console.error("Failed to add task:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  const toggleTask = async (taskId) => {
    try {
      setStatus("Updating task...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const tx = await contract.toggleTask(taskId);
      await tx.wait();

      setStatus("✅ Task updated!");
      loadTasks();
    } catch (err) {
      console.error("Failed to toggle task:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <div>
      <h2>OnChain Todo List</h2>

      <form onSubmit={addTask}>
        <input
          placeholder="Enter task description"
          value={newTaskText}
          onChange={(e) => setNewTaskText(e.target.value)}
          required
        />
        <button type="submit">Add Task</button>
      </form>

      {status && <p>{status}</p>}

      <div>
        <h3>Your Tasks</h3>
        <ul>
          {tasks.map((task) => (
            <li key={task.id}>
              <input
                type="checkbox"
                checked={task.completed}
                onChange={() => toggleTask(task.id)}
              />
              <span
                style={{
                  textDecoration: task.completed ? "line-through" : "none",
                }}
              >
                {task.text}
              </span>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
```

## Lesson 10: DAO Voting UI

### Activity 1: Fetch & Render Proposals

**Solution for ProposalList.js:**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/DAO.json";

export default function ProposalList() {
  const [proposals, setProposals] = useState([]);

  useEffect(() => {
    const fetchProposals = async () => {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        const proposalCount = await contract.proposalCount();
        const allProposals = [];

        for (let i = 0; i < proposalCount.toNumber(); i++) {
          const proposal = await contract.proposals(i);
          allProposals.push({
            id: i,
            title: proposal.title,
            description: proposal.description,
            yesVotes: proposal.yesVotes.toNumber(),
            noVotes: proposal.noVotes.toNumber(),
            deadline: proposal.deadline.toNumber(),
            executed: proposal.executed,
          });
        }

        setProposals(allProposals);
      } catch (err) {
        console.error("Failed to fetch proposals:", err);
      }
    };

    fetchProposals();
  }, []);

  return (
    <div>
      <h3>DAO Proposals</h3>
      {proposals.map((proposal) => (
        <div
          key={proposal.id}
          style={{ border: "1px solid #ccc", margin: "10px", padding: "10px" }}
        >
          <h4>{proposal.title}</h4>
          <p>{proposal.description}</p>
          <p>
            Yes: {proposal.yesVotes} | No: {proposal.noVotes}
          </p>
          <p>Status: {proposal.executed ? "Executed" : "Active"}</p>
        </div>
      ))}
    </div>
  );
}
```

### Activity 2: Vote on Proposals

**Solution for VotingInterface.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/DAO.json";

export default function VotingInterface({ proposals, onVoteComplete }) {
  const [status, setStatus] = useState("");

  const vote = async (proposalId, support) => {
    try {
      setStatus("Submitting vote...");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const tx = await contract.vote(proposalId, support);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Vote submitted!");

      if (onVoteComplete) {
        onVoteComplete();
      }
    } catch (err) {
      console.error("Failed to vote:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <div>
      <h3>Vote on Proposals</h3>
      {status && <p>{status}</p>}

      {proposals.map((proposal) => (
        <div
          key={proposal.id}
          style={{ border: "1px solid #ccc", margin: "10px", padding: "10px" }}
        >
          <h4>{proposal.title}</h4>
          <p>{proposal.description}</p>
          <p>
            Yes: {proposal.yesVotes} | No: {proposal.noVotes}
          </p>

          {!proposal.executed && (
            <div>
              <button onClick={() => vote(proposal.id, true)}>Vote Yes</button>
              <button onClick={() => vote(proposal.id, false)}>Vote No</button>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
```

### Activity 3: Create New Proposal

**Solution for CreateProposal.js:**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/DAO.json";

export default function CreateProposal({ onProposalCreated }) {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [duration, setDuration] = useState("7"); // days
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!title.trim() || !description.trim()) return;

    try {
      setStatus("Creating proposal...");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      // Convert duration from days to seconds
      const durationInSeconds = parseInt(duration) * 24 * 60 * 60;

      const tx = await contract.createProposal(
        title,
        description,
        durationInSeconds
      );
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Proposal created!");

      setTitle("");
      setDescription("");
      setDuration("7");

      if (onProposalCreated) {
        onProposalCreated();
      }
    } catch (err) {
      console.error("Failed to create proposal:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Create New Proposal</h3>

      <div>
        <input
          placeholder="Proposal Title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          required
        />
      </div>

      <div>
        <textarea
          placeholder="Proposal Description"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          rows="4"
          required
        />
      </div>

      <div>
        <label>Voting Duration (days):</label>
        <input
          type="number"
          value={duration}
          onChange={(e) => setDuration(e.target.value)}
          min="1"
          required
        />
      </div>

      <button type="submit">Create Proposal</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

## Lesson 11: Real Time Gas Fee Tracker

### Activity 1: Deploy & Fetch Base Fee

**Solution for GasStats.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );
        const fee = await contract.getBaseFee();
        setBase(fee);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchBaseFee();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (base === null) return <p>Loading base fee…</p>;
  return <p>Current Base Fee: {base.toString()} gwei</p>;
}
```

### Activity 2: Calculate Gas Tiers

**Solution for GasTiers.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasTiers() {
  const [tiers, setTiers] = useState(null);

  useEffect(() => {
    async function calcTiers() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );

        const base = await contract.getBaseFee();
        const low = base.mul(9).div(10); // 90%
        const med = base; // 100%
        const high = base.mul(11).div(10); // 110%

        setTiers({ low, med, high });
      } catch (err) {
        console.error("Error calculating tiers:", err);
      }
    }
    calcTiers();
  }, []);

  if (!tiers) return <p>Calculating tiers…</p>;
  return (
    <ul>
      <li>Low: {tiers.low.toString()} gwei</li>
      <li>Medium: {tiers.med.toString()} gwei</li>
      <li>High: {tiers.high.toString()} gwei</li>
    </ul>
  );
}
```

### Activity 3: PHP Estimates & Auto-Refresh

**Solution for GasDashboard.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasDashboard() {
  const [phpRates, setPhpRates] = useState(null);

  useEffect(() => {
    const rate = 80; // mock ₱80 per ETH

    async function update() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );

        const base = await contract.getBaseFee();
        const low = base.mul(9).div(10);
        const med = base;
        const high = base.mul(11).div(10);

        // Convert to ETH and then to PHP
        const lowEth = parseFloat(ethers.utils.formatUnits(low, "gwei"));
        const medEth = parseFloat(ethers.utils.formatUnits(med, "gwei"));
        const highEth = parseFloat(ethers.utils.formatUnits(high, "gwei"));

        setPhpRates({
          lowP: (lowEth * rate).toFixed(6),
          medP: (medEth * rate).toFixed(6),
          highP: (highEth * rate).toFixed(6),
        });
      } catch (err) {
        console.error("Error updating rates:", err);
      }
    }

    update();
    const id = setInterval(update, 15000);
    return () => clearInterval(id);
  }, []);

  if (!phpRates) return <p>Loading PHP estimates…</p>;
  return (
    <div>
      <h3>Gas Fee in PHP</h3>
      <p>Low: ₱{phpRates.lowP}</p>
      <p>Med: ₱{phpRates.medP}</p>
      <p>High: ₱{phpRates.highP}</p>
    </div>
  );
}
```

## Lesson 12: DeFi Dashboard

### Activity 1: Fetch LP Reserves & Total Supply

**Solution for LPStats.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
];

export default function LPStats() {
  const [reserves, setReserves] = useState({ r0: null, r1: null });
  const [supply, setSupply] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchStats() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_LP_ADDRESS,
          ABI,
          provider
        );

        const [r0, r1] = await contract.getReserves();
        const ts = await contract.getTotalSupply();

        setReserves({ r0, r1 });
        setSupply(ts);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (reserves.r0 === null) return <p>Loading LP data…</p>;
  return (
    <div>
      <h3>LP Reserves & Supply</h3>
      <p>Reserve0: {reserves.r0.toString()}</p>
      <p>Reserve1: {reserves.r1.toString()}</p>
      <p>Total Supply: {supply.toString()}</p>
    </div>
  );
}
```

### Activity 2: Calculate Pool Ratio & APR

**Solution for PoolAnalytics.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getMockAPR() view returns (uint256)",
];

export default function PoolAnalytics() {
  const [analytics, setAnalytics] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function calcAnalytics() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_LP_ADDRESS,
          ABI,
          provider
        );

        const [r0, r1] = await contract.getReserves();
        const aprBps = await contract.getMockAPR();

        // Calculate ratio (r1/r0)
        const ratio = parseFloat(r1.toString()) / parseFloat(r0.toString());

        // Convert basis points to percentage
        const aprPercent = aprBps.toNumber() / 100;

        setAnalytics({
          ratio: ratio.toFixed(6),
          apr: aprPercent.toFixed(2),
        });
      } catch (err) {
        setError(err.message);
      }
    }
    calcAnalytics();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (!analytics) return <p>Calculating analytics…</p>;
  return (
    <div>
      <h3>Pool Analytics</h3>
      <p>Token Ratio: {analytics.ratio}</p>
      <p>APR: {analytics.apr}%</p>
    </div>
  );
}
```

### Activity 3: LP Token Calculator

**Solution for LPCalculator.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
];

export default function LPCalculator() {
  const [userInput, setUserInput] = useState("");
  const [lpTokens, setLpTokens] = useState("");
  const [poolData, setPoolData] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadPoolData() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_LP_ADDRESS,
          ABI,
          provider
        );

        const [r0, r1] = await contract.getReserves();
        const totalSupply = await contract.getTotalSupply();

        setPoolData({ r0, r1, totalSupply });
      } catch (err) {
        setError(err.message);
      }
    }
    loadPoolData();
  }, []);

  const calculateLPTokens = () => {
    if (!userInput || !poolData) return;

    const inputAmount = parseFloat(userInput);
    const reserve0 = parseFloat(poolData.r0.toString());
    const supply = parseFloat(poolData.totalSupply.toString());

    // LP tokens = (input amount / reserve0) * total supply
    const lpAmount = (inputAmount / reserve0) * supply;
    setLpTokens(lpAmount.toFixed(6));
  };

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (!poolData) return <p>Loading pool data…</p>;

  return (
    <div>
      <h3>LP Token Calculator</h3>
      <input
        type="number"
        placeholder="Enter token amount"
        value={userInput}
        onChange={(e) => setUserInput(e.target.value)}
      />
      <button onClick={calculateLPTokens}>Calculate LP Tokens</button>
      {lpTokens && <p>LP Tokens: {lpTokens}</p>}
    </div>
  );
}
```

## Lesson 13: Multisig Transaction Initiator

### Activity 1: List All Proposals

**Solution for ProposalList.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const contract = new ethers.Contract(contractAddress, ABI, provider);

        const count = await contract.getTransactionCount();
        const proposals = [];

        for (let i = 0; i < count.toNumber(); i++) {
          const tx = await contract.transactions(i);
          proposals.push({
            id: i,
            to: tx.to,
            value: ethers.utils.formatEther(tx.value),
            data: tx.data.slice(0, 10) + "...", // Show first few bytes
            executed: tx.executed,
            confirmations: tx.numConfirmations.toNumber(),
          });
        }

        setProposals(proposals);
      } catch (err) {
        setError(err.message);
      }
    }
    loadProposals();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (proposals.length === 0) return <p>Loading proposals…</p>;

  return (
    <div>
      <h3>Multisig Proposals</h3>
      {proposals.map((proposal) => (
        <div
          key={proposal.id}
          style={{ border: "1px solid #ccc", margin: "10px", padding: "10px" }}
        >
          <h4>Proposal #{proposal.id}</h4>
          <p>To: {proposal.to}</p>
          <p>Value: {proposal.value} ETH</p>
          <p>Data: {proposal.data}</p>
          <p>Confirmations: {proposal.confirmations}</p>
          <p>Status: {proposal.executed ? "✅ Executed" : "⏳ Pending"}</p>
        </div>
      ))}
    </div>
  );
}
```

### Activity 2: Submit New Transaction

**Solution for SubmitTransaction.js:**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function submitTransaction(address _to, uint256 _value, bytes _data) returns (uint256)",
];

export default function SubmitTransaction({ contractAddress, onSubmitted }) {
  const [to, setTo] = useState("");
  const [value, setValue] = useState("");
  const [data, setData] = useState("0x");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setStatus("Submitting transaction...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(contractAddress, ABI, signer);
      const valueInWei = ethers.utils.parseEther(value || "0");

      const tx = await contract.submitTransaction(to, valueInWei, data);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Transaction submitted!");

      setTo("");
      setValue("");
      setData("0x");

      if (onSubmitted) {
        onSubmitted();
      }
    } catch (err) {
      console.error("Failed to submit transaction:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Submit New Transaction</h3>

      <div>
        <input
          placeholder="To Address"
          value={to}
          onChange={(e) => setTo(e.target.value)}
          required
        />
      </div>

      <div>
        <input
          type="number"
          step="0.001"
          placeholder="Value in ETH"
          value={value}
          onChange={(e) => setValue(e.target.value)}
        />
      </div>

      <div>
        <input
          placeholder="Data (hex)"
          value={data}
          onChange={(e) => setData(e.target.value)}
        />
      </div>

      <button type="submit">Submit Transaction</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

### Activity 3: Confirm Transaction

**Solution for ConfirmTransaction.js:**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function confirmTransaction(uint256 _txId)",
  "function confirmations(uint256, address) view returns (bool)",
];

export default function ConfirmTransaction({
  contractAddress,
  proposals,
  onConfirmed,
}) {
  const [status, setStatus] = useState("");
  const [account, setAccount] = useState("");

  React.useEffect(() => {
    const getAccount = async () => {
      if (window.ethereum) {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const accounts = await provider.send("eth_requestAccounts", []);
        setAccount(accounts[0]);
      }
    };
    getAccount();
  }, []);

  const confirmTx = async (txId) => {
    try {
      setStatus("Confirming transaction...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(contractAddress, ABI, signer);

      // Check if already confirmed
      const isConfirmed = await contract.confirmations(txId, account);
      if (isConfirmed) {
        setStatus("❌ You have already confirmed this transaction");
        return;
      }

      const tx = await contract.confirmTransaction(txId);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Transaction confirmed!");

      if (onConfirmed) {
        onConfirmed();
      }
    } catch (err) {
      console.error("Failed to confirm transaction:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <div>
      <h3>Confirm Transactions</h3>
      {status && <p>{status}</p>}

      {proposals
        .filter((p) => !p.executed)
        .map((proposal) => (
          <div
            key={proposal.id}
            style={{
              border: "1px solid #ccc",
              margin: "10px",
              padding: "10px",
            }}
          >
            <h4>Proposal #{proposal.id}</h4>
            <p>To: {proposal.to}</p>
            <p>Value: {proposal.value} ETH</p>
            <p>Confirmations: {proposal.confirmations}</p>
            <button onClick={() => confirmTx(proposal.id)}>
              Confirm Transaction
            </button>
          </div>
        ))}
    </div>
  );
}
```

## Lesson 14: Simulated Chain Oracle DApp

### Activity 1: Build ReliefStats Component

**Solution for ReliefStats.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const relief = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          ABI,
          provider
        );

        const ws = await relief.windSpeed();
        const rel = await relief.released();
        const bal = await provider.getBalance(
          process.env.REACT_APP_CONTRACT_ADDRESS
        );

        setWind(ws.toNumber());
        setReleased(rel);
        setBalance(ethers.utils.formatEther(bal));
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (wind === null) return <p>Loading relief stats…</p>;
  return (
    <div>
      <h3>Typhoon Relief Chain Stats</h3>
      <p>Wind Speed: {wind} km/h</p>
      <p>Pool Balance: {balance} ETH</p>
      <p>Released: {released ? "✅ Funds Dispatched" : "❌ Pending"}</p>
    </div>
  );
}
```

### Activity 2: Weather Update Interface

**Solution for WeatherUpdater.js:**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function updateWeather(uint256 _speed)",
  "event DataUpdated(uint256 windSpeed)",
  "event Released(address beneficiary, uint256 amount)",
];

export default function WeatherUpdater({ onUpdate }) {
  const [windSpeed, setWindSpeed] = useState("");
  const [status, setStatus] = useState("");

  const updateWeather = async (e) => {
    e.preventDefault();
    try {
      setStatus("Updating weather data...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        ABI,
        signer
      );

      const tx = await contract.updateWeather(parseInt(windSpeed));
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Weather data updated!");

      setWindSpeed("");

      if (onUpdate) {
        onUpdate();
      }
    } catch (err) {
      console.error("Failed to update weather:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={updateWeather}>
      <h3>Update Weather Data</h3>
      <input
        type="number"
        placeholder="Wind Speed (km/h)"
        value={windSpeed}
        onChange={(e) => setWindSpeed(e.target.value)}
        required
      />
      <button type="submit">Update Weather</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

### Activity 3: Donation Interface

**Solution for DonationInterface.js:**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function donate() payable"];

export default function DonationInterface({ onDonation }) {
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");

  const donate = async (e) => {
    e.preventDefault();
    try {
      setStatus("Processing donation...");

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        ABI,
        signer
      );

      const value = ethers.utils.parseEther(amount);
      const tx = await contract.donate({ value });
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Donation successful! Thank you!");

      setAmount("");

      if (onDonation) {
        onDonation();
      }
    } catch (err) {
      console.error("Failed to donate:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={donate}>
      <h3>Donate to Relief Fund</h3>
      <input
        type="number"
        step="0.001"
        placeholder="Amount in ETH"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        required
      />
      <button type="submit">Donate</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

## Lesson 15: OnChain Identity Viewer

### Activity 1: Profile Display Component

**Solution for ProfileViewer.js:**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function profiles(address) view returns (string name, string bio, string avatar, bool exists)",
];

export default function ProfileViewer({ address }) {
  const [profile, setProfile] = useState(null);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!address) return;

    async function loadProfile() {
      setLoading(true);
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          ABI,
          provider
        );

        const profileData = await contract.profiles(address);

        if (profileData.exists) {
          setProfile({
            name: profileData.name,
            bio: profileData.bio,
            avatar: profileData.avatar,
            address: address,
          });
        } else {
          setProfile(null);
        }
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    loadProfile();
  }, [address]);

  if (loading) return <p>Loading profile…</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (!profile) return <p>No profile found for this address.</p>;

  return (
    <div style={{ border: "1px solid #ccc", padding: "20px", margin: "10px" }}>
      <div style={{ display: "flex", alignItems: "center", gap: "15px" }}>
        {profile.avatar && (
          <img
            src={profile.avatar}
            alt={profile.name}
            style={{ width: "60px", height: "60px", borderRadius: "50%" }}
          />
        )}
        <div>
          <h3>{profile.name}</h3>
          <p style={{ fontSize: "12px", color: "#666" }}>
            {profile.address.slice(0, 6)}...{profile.address.slice(-4)}
          </p>
        </div>
      </div>
      <p style={{ marginTop: "10px" }}>{profile.bio}</p>
    </div>
  );
}
```

### Activity 2: Profile Search Interface

**Solution for ProfileSearch.js:**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
import ProfileViewer from "./ProfileViewer";

export default function ProfileSearch() {
  const [searchAddress, setSearchAddress] = useState("");
  const [currentAddress, setCurrentAddress] = useState("");
  const [error, setError] = useState("");

  const handleSearch = (e) => {
    e.preventDefault();
    setError("");

    if (!ethers.utils.isAddress(searchAddress)) {
      setError("Invalid Ethereum address");
      return;
    }

    setCurrentAddress(searchAddress);
  };

  return (
    <div>
      <form onSubmit={handleSearch}>
        <h3>Search Profile</h3>
        <input
          type="text"
          placeholder="Enter Ethereum address (0x...)"
          value={searchAddress}
          onChange={(e) => setSearchAddress(e.target.value)}
          style={{ width: "400px", padding: "8px" }}
        />
        <button type="submit">Search</button>
        {error && <p style={{ color: "red" }}>{error}</p>}
      </form>

      {currentAddress && <ProfileViewer address={currentAddress} />}
    </div>
  );
}
```

### Activity 3: Profile Registration Form

**Solution for ProfileRegistration.js:**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function updateProfile(string name, string bio, string avatar)",
  "event ProfileUpdated(address indexed user, string name)",
];

export default function ProfileRegistration({ onRegistered }) {
  const [name, setName] = useState("");
  const [bio, setBio] = useState("");
  const [avatar, setAvatar] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setStatus("Updating profile...");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        ABI,
        signer
      );

      const tx = await contract.updateProfile(name, bio, avatar);
      setStatus("Transaction sent. Waiting for confirmation...");

      await tx.wait();
      setStatus("✅ Profile updated successfully!");

      // Reset form
      setName("");
      setBio("");
      setAvatar("");

      if (onRegistered) {
        onRegistered();
      }
    } catch (err) {
      console.error("Failed to update profile:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Update Your Profile</h3>

      <div style={{ marginBottom: "10px" }}>
        <input
          type="text"
          placeholder="Your Name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
          style={{ width: "100%", padding: "8px" }}
        />
      </div>

      <div style={{ marginBottom: "10px" }}>
        <textarea
          placeholder="Bio"
          value={bio}
          onChange={(e) => setBio(e.target.value)}
          rows="3"
          style={{ width: "100%", padding: "8px" }}
        />
      </div>

      <div style={{ marginBottom: "10px" }}>
        <input
          type="url"
          placeholder="Avatar URL"
          value={avatar}
          onChange={(e) => setAvatar(e.target.value)}
          style={{ width: "100%", padding: "8px" }}
        />
      </div>

      <button type="submit">Update Profile</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

## Lesson 16 Solutions

### Activity 1: EscrowStats Component

```jsx
// EscrowStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amount, setAmount] = useState("0");
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const escrow = new ethers.Contract(ADDR, ABI, provider);
        const [b, s, amt, dep, rel] = await Promise.all([
          escrow.buyer(),
          escrow.seller(),
          escrow.amount(),
          escrow.deposited(),
          escrow.released(),
        ]);
        setBuyer(b);
        setSeller(s);
        setAmount(ethers.utils.formatEther(amt));
        setDeposited(dep);
        setReleased(rel);
      } catch (err) {
        console.error("Failed to load escrow:", err);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  if (loading) return <p>Loading escrow info...</p>;

  return (
    <div style={{ border: "1px solid #ccc", padding: 16 }}>
      <h3>🤝 Escrow Contract</h3>
      <p>
        <strong>Buyer:</strong> {buyer}
      </p>
      <p>
        <strong>Seller:</strong> {seller}
      </p>
      <p>
        <strong>Amount:</strong> {amount} ETH
      </p>
      <p>
        <strong>Status:</strong>{" "}
        {released ? "✅ Released" : deposited ? "⏳ Deposited" : "❌ Pending"}
      </p>
    </div>
  );
}
```

### Activity 2: DepositFunds Component

```jsx
// DepositFunds.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function deposit() payable",
];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function DepositFunds({ onAction }) {
  const [account, setAccount] = useState("");
  const [buyer, setBuyer] = useState("");
  const [amount, setAmount] = useState("0");
  const [deposited, setDeposited] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function load() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const [acct] = await window.ethereum.request({
          method: "eth_accounts",
        });
        setAccount(acct);
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const escrow = new ethers.Contract(ADDR, ABI, provider);
        const [b, amt, dep] = await Promise.all([
          escrow.buyer(),
          escrow.amount(),
          escrow.deposited(),
        ]);
        setBuyer(b);
        setAmount(ethers.utils.formatEther(amt));
        setDeposited(dep);
      } catch (err) {
        setError(err.message);
      }
    }
    load();
  }, []);

  async function doDeposit() {
    setLoading(true);
    setError("");
    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const escrow = new ethers.Contract(ADDR, ABI, signer);
      const amountWei = await escrow.amount();
      const tx = await escrow.deposit({ value: amountWei });
      await tx.wait();
      onAction();
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  if (deposited) return <p>✅ Funds already deposited</p>;
  if (account.toLowerCase() !== buyer.toLowerCase()) {
    return <p>Only the buyer can deposit funds</p>;
  }

  return (
    <div>
      <button onClick={doDeposit} disabled={loading}>
        {loading ? "Depositing..." : `Deposit ${amount} ETH`}
      </button>
      {error && <p style={{ color: "red" }}>Error: {error}</p>}
    </div>
  );
}
```

### Activity 3: ReleaseControls Component

```jsx
// ReleaseControls.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
  "function release()",
  "function refund()",
];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function ReleaseControls({ onAction }) {
  const [account, setAccount] = useState("");
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);

  useEffect(() => {
    async function load() {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const [acct] = await window.ethereum.request({ method: "eth_accounts" });
      setAccount(acct);
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const escrow = new ethers.Contract(ADDR, ABI, provider);
      const [b, s, dep, rel] = await Promise.all([
        escrow.buyer(),
        escrow.seller(),
        escrow.deposited(),
        escrow.released(),
      ]);
      setBuyer(b);
      setSeller(s);
      setDeposited(dep);
      setReleased(rel);
    }
    load();
  }, []);

  async function doRelease() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const escrow = new ethers.Contract(ADDR, ABI, signer);
    const tx = await escrow.release();
    await tx.wait();
    onAction();
  }

  async function doRefund() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const escrow = new ethers.Contract(ADDR, ABI, signer);
    const tx = await escrow.refund();
    await tx.wait();
    onAction();
  }

  if (!deposited || released) return null;
  return (
    <div>
      {account.toLowerCase() === buyer.toLowerCase() && (
        <button onClick={doRelease}>Release Funds</button>
      )}
      {account.toLowerCase() === seller.toLowerCase() && (
        <button onClick={doRefund}>Refund Buyer</button>
      )}
    </div>
  );
}
```

## Lesson 17 Solutions

### Activity 1: NetworkStats Component

```jsx
// NetworkStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getChainId() view returns (uint256)"];
const RPC = process.env.REACT_APP_RPC_URL;
const CONTRACT = process.env.REACT_APP_NETWORK_DETECTOR;

const NAMES = {
  1: "Ethereum Mainnet",
  5: "Goerli",
  11155111: "Sepolia",
  137: "Polygon",
  80001: "Mumbai",
};

export default function NetworkStats() {
  const [chainId, setChainId] = useState(null);
  const [chainName, setChainName] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    let provider, contract;

    async function loadChain() {
      try {
        if (window.ethereum) {
          provider = new ethers.providers.Web3Provider(window.ethereum);
          await window.ethereum.request({ method: "eth_requestAccounts" });
        } else {
          provider = new ethers.providers.JsonRpcProvider(RPC);
        }
        contract = new ethers.Contract(CONTRACT, ABI, provider);
        const idBN = await contract.getChainId();
        const id = idBN.toNumber();
        setChainId(id);
        setChainName(NAMES[id] || "Unknown");
      } catch (err) {
        setError(err.message);
      }
    }

    loadChain();

    function handleChange(chainHex) {
      // chainHex e.g. "0xaa36a7"
      const id = parseInt(chainHex, 16);
      setChainId(id);
      setChainName(NAMES[id] || "Unknown");
    }

    if (window.ethereum) {
      window.ethereum.on("chainChanged", handleChange);
    }

    return () => {
      if (window.ethereum) {
        window.ethereum.removeListener("chainChanged", handleChange);
      }
    };
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (chainId === null) return <p>Detecting network…</p>;

  return (
    <div>
      <h3>Current Network</h3>
      <p>
        Chain ID: <strong>{chainId}</strong>
      </p>
      <p>
        Chain Name: <strong>{chainName}</strong>
      </p>
    </div>
  );
}
```

### Activity 2: NetworkSwitcher Component

```jsx
// NetworkSwitcher.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

export default function NetworkSwitcher({ targetChainId }) {
  const [currentChain, setCurrentChain] = useState(null);
  const [status, setStatus] = useState("");

  useEffect(() => {
    async function fetchChain() {
      if (window.ethereum) {
        const hex = await window.ethereum.request({ method: "eth_chainId" });
        setCurrentChain(parseInt(hex, 16));
      }
    }
    fetchChain();
  }, []);

  async function switchNetwork() {
    setStatus("");
    const hexId = ethers.utils.hexValue(targetChainId);
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: hexId }],
      });
      setStatus("✅ Switched!");
      setCurrentChain(targetChainId);
    } catch (err) {
      if (err.code === 4902) {
        setStatus("Network not found in MetaMask – please add it first.");
      } else if (err.code === 4001) {
        setStatus("User rejected the request.");
      } else {
        setStatus(err.message);
      }
    }
  }

  return (
    <div>
      <p>
        Current Chain ID: <strong>{currentChain}</strong>
      </p>
      {currentChain !== targetChainId && (
        <button onClick={switchNetwork}>Switch to {targetChainId}</button>
      )}
      {status && <p>{status}</p>}
    </div>
  );
}
```

## Lesson 18 Solutions

### Activity 1: NFTPreview Component

```jsx
// NFTPreview.js
import React from "react";

export default function NFTPreview({ title, description, file }) {
  if (!file) {
    return <p>Please upload an image to preview your NFT.</p>;
  }

  const imageUrl = URL.createObjectURL(file);
  const metadata = {
    name: title || "Untitled",
    description: description || "",
    image: imageUrl,
  };

  return (
    <div style={{ border: "1px solid #ccc", padding: 16 }}>
      <h4>🖼️ Image Preview</h4>
      <img
        src={imageUrl}
        alt="NFT preview"
        style={{ maxWidth: "100%", maxHeight: 200 }}
      />
      <h4>{metadata.name}</h4>
      <p>{metadata.description}</p>
      <h5>Metadata JSON:</h5>
      <pre style={{ background: "#f9f9f9", padding: 8 }}>
        {JSON.stringify(metadata, null, 2)}
      </pre>
    </div>
  );
}
```

### Activity 2: MintNFT Component

```jsx
// MintNFT.js
import React, { useState } from "react";
import { ethers } from "ethers";
import { Buffer } from "buffer";

const ABI = [
  "function mintNFT(string) returns (uint256)",
  "event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI)",
];
const ADDRESS = process.env.REACT_APP_POETNFT_ADDRESS;

export default function MintNFT({ title, description, file }) {
  const [tokenId, setTokenId] = useState(null);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function mint() {
    setError("");
    setLoading(true);
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(ADDRESS, ABI, signer);

      // Build metadata
      const imageData = await file.arrayBuffer();
      const base64Img = Buffer.from(imageData).toString("base64");
      const mimeType = file.type; // e.g., "image/png"
      const imageUri = `data:${mimeType};base64,${base64Img}`;

      const metadata = {
        name: title,
        description,
        image: imageUri,
      };
      const json = JSON.stringify(metadata);
      const dataUri = `data:application/json;base64,${Buffer.from(
        json
      ).toString("base64")}`;

      const tx = await contract.mintNFT(dataUri);
      const receipt = await tx.wait();
      const event = receipt.events.find((e) => e.event === "Minted");
      const newId = event.args.tokenId.toNumber();
      setTokenId(newId);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <button onClick={mint} disabled={loading || !file}>
        {loading ? "Minting…" : "Mint NFT"}
      </button>
      {tokenId !== null && (
        <p>
          ✅ Minted Token ID: {tokenId} &nbsp;
          <a href={`#`} target="_blank" rel="noopener noreferrer">
            View Metadata
          </a>
        </p>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## Lesson 19 Solutions

### Activity 1: DeploySimulator Component

```jsx
// DeploySimulator.js
import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";

export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function deploy() {
    setError("");
    setLoading(true);
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const factory = new ethers.ContractFactory(
        HelloWorldArtifact.abi,
        HelloWorldArtifact.bytecode,
        signer
      );
      const contract = await factory.deploy(greet);
      await contract.deployed();
      onDeployed(contract.address);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <h4>Deploy HelloWorld Contract</h4>
      <input
        placeholder="Greeting message"
        value={greet}
        onChange={(e) => setGreet(e.target.value)}
      />
      <button onClick={deploy} disabled={loading || !greet}>
        {loading ? "Deploying…" : "Deploy"}
      </button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

### Activity 2: DeployHistory Component

```jsx
// DeployHistory.js
import React from "react";

export default function DeployHistory({ history }) {
  if (!history.length) {
    return <p>No deployments yet.</p>;
  }
  return (
    <div style={{ maxHeight: 200, overflowY: "auto" }}>
      <ul>
        {history.map((h, i) => (
          <li key={i} style={{ marginBottom: 8 }}>
            <code>{h.address}</code>
            <br />
            <small>{new Date(h.timestamp).toLocaleString()}</small>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

## Lesson 20 Solutions

### Activity 1: LockForm Component

```jsx
// LockForm.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function lockTokens() payable returns (uint256)",
  "event Locked(address indexed user, uint256 amount, uint256 id)",
];

export default function LockForm({ onLocked }) {
  const [amt, setAmt] = useState("");
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Locking
  const [error, setError] = useState("");

  async function doLock() {
    try {
      setError("");
      setStep("Locking");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );
      const tx = await bridge.lockTokens({
        value: ethers.utils.parseEther(amt),
      });
      const receipt = await tx.wait();
      const evt = receipt.events.find((e) => e.event === "Locked");
      const id = evt.args.id.toNumber();
      onLocked(id, amt);
      setStep("Idle");
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      <h4>Amount to Bridge</h4>
      <input
        placeholder="ETH"
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        disabled={step !== "Idle"}
      />
      <button
        onClick={() => setStep("Confirm")}
        disabled={!amt || isNaN(amt) || Number(amt) <= 0 || step !== "Idle"}
      >
        Bridge
      </button>
      {step === "Confirm" && (
        <div className="modal">
          <p>Lock {amt} ETH on PHChain?</p>
          <button onClick={doLock}>Yes, lock</button>
          <button onClick={() => setStep("Idle")}>Cancel</button>
        </div>
      )}
      {step === "Locking" && <p>⏳ Locking on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

### Activity 2: ReleaseFlow Component

```jsx
// ReleaseFlow.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function releaseTokens(uint256)",
  "event Released(address indexed user, uint256 amount, uint256 id)",
];

export default function ReleaseFlow({ lockId, amount, onDone }) {
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Releasing
  const [error, setError] = useState("");

  async function doRelease() {
    try {
      setError("");
      setStep("Releasing");
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );
      const tx = await bridge.releaseTokens(lockId);
      await tx.wait();
      onDone();
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      {step === "Idle" && (
        <button onClick={() => setStep("Confirm")}>
          Release {amount} ETH on NYChain
        </button>
      )}
      {step === "Confirm" && (
        <div className="modal">
          <p>Release {amount} ETH on NYChain?</p>
          <button onClick={doRelease}>Yes, release</button>
          <button onClick={() => setStep("Idle")}>Cancel</button>
        </div>
      )}
      {step === "Releasing" && <p>⏳ Releasing on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```
