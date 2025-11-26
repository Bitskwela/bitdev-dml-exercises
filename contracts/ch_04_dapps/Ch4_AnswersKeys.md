# Answer Keys for Chapter 4: DApps

## Lesson 1: Connect my Metamask

```javascript
import { useState } from "react";

export default function WalletConnector() {
  const [account, setAccount] = useState(null);

  // Task 1: Detect MetaMask installation
  const hasWallet = Boolean(window.ethereum);

  // Task 2: Implement wallet connection logic
  const connectWallet = async () => {
    if (!window.ethereum) return alert("Please install MetaMask!");

    try {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(accounts[0]);
    } catch (error) {
      console.error("User rejected wallet connection", error);
    }
  };

  // Task 3: Implement conditional rendering
  return (
    <div>
      {window.ethereum ? (
        account ? (
          <p>Connected: {account}</p>
        ) : (
          <button onClick={connectWallet}>Connect MetaMask 🦊</button>
        )
      ) : (
        <p>Please install MetaMask to continue.</p>
      )}
    </div>
  );
}
```

## Lesson 2: Read Smart Contract Data

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NFTReader() {
  const [info, setInfo] = useState({ name: "", symbol: "", total: 0 });
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");

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

      const [name, symbol, total] = await Promise.all([
        contract.name(),
        contract.symbol(),
        contract.totalMinted(),
      ]);

      setInfo({ name, symbol, total: total.toNumber() });
    }
    fetchInfo();
  }, []);

  const fetchTokenURI = async () => {
    if (tokenId < 0 || tokenId >= info.total) {
      alert(`Please enter a token ID between 0 and ${info.total - 1}`);
      return;
    }

    try {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      const fetchedUri = await contract.tokenURIs(tokenId);
      setUri(fetchedUri);
    } catch (error) {
      console.error("Error fetching token URI:", error);
      alert("Failed to fetch URI. The token might not exist.");
    }
  };

  return (
    <div>
      <h1>{info.name || "Loading..."}</h1>
      <h3>{info.symbol || "Loading..."}</h3>
      <p>Total Minted: {info.total}</p>
      <input
        type="number"
        value={tokenId}
        onChange={(e) => setTokenId(Number(e.target.value))}
      />
      <button onClick={fetchTokenURI}>Get Token URI</button>
      {uri && <p>URI: {uri}</p>}
    </div>
  );
}
```

## Lesson 3: Triggering a Function

```javascript
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

## Lesson 4: Event Listeners in the Frontend

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);

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
      setHistory((prev) => [winnerAddress, ...prev].slice(0, 5));
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);

  return (
    <div>
      <h2>🎰 Raffle Listener</h2>
      <div>
        <h3>Latest Winner:</h3>
        <p>{winner || "Waiting for winner..."}</p>
      </div>
      <div>
        <h3>Winner History (Last 5):</h3>
        <ul>
          {history.map((w, i) => (
            <li key={i}>{w}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}
```

## Lesson 5: Sign In with Wallet Experience

```javascript
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/Authenticator.json";

export default function WalletAuth() {
  const [account, setAccount] = useState(null);
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [error, setError] = useState("");

  const connectWallet = async () => {
    try {
      setError("");
      if (!window.ethereum) {
        setError("Please install MetaMask!");
        return;
      }

      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const address = await signer.getAddress();
      setAccount(address);
    } catch (err) {
      console.error("Connection failed:", err);
      setError("Failed to connect wallet");
    }
  };

  const signMessage = async () => {
    try {
      setError("");
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const nonce = Date.now().toString();
      const msg = `Sign in to Dashboard\n\nNonce: ${nonce}`;

      const sig = await signer.signMessage(msg);
      setMessage(msg);
      setSignature(sig);
    } catch (err) {
      console.error("Signing failed:", err);
      setError("Failed to sign message");
    }
  };

  const verifySignature = async () => {
    try {
      setError("");
      const msgHash = ethers.utils.id(message);
      const { v, r, s } = ethers.utils.splitSignature(signature);

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      const isValid = await contract.verify(account, msgHash, v, r, s);

      if (isValid) {
        setIsAuthenticated(true);
      } else {
        setError("Signature verification failed");
      }
    } catch (err) {
      console.error("Verification failed:", err);
      setError("Failed to verify signature");
    }
  };

  return (
    <div>
      {!account ? (
        <button onClick={connectWallet}>Connect Wallet</button>
      ) : !signature ? (
        <div>
          <p>Connected: {account}</p>
          <button onClick={signMessage}>Sign In</button>
        </div>
      ) : !isAuthenticated ? (
        <div>
          <p>Signature: {signature.slice(0, 20)}...</p>
          <button onClick={verifySignature}>Verify & Unlock</button>
        </div>
      ) : (
        <div>
          <h2>🚀 Welcome to the Dashboard!</h2>
          <p>Authenticated as: {account}</p>
        </div>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## Lesson 6: Token Tracker

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  const [account, setAccount] = useState("");

  // Task 1 & 2: Fetch token info
  useEffect(() => {
    const fetchTokenInfo = async () => {
      // Task 1: Validate address and create contract instance
      if (!ethers.utils.isAddress(tokenAddress)) return;

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      // Task 2: Fetch token metadata using Promise.all
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

  // Task 3: Implement the fetchBalance function
  const fetchBalance = async () => {
    try {
      const [user] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(user);

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      const rawBalance = await contract.balanceOf(user);
      const formatted = ethers.utils.formatUnits(rawBalance, info.decimals);
      setBalance(`${formatted} ${info.symbol}`);
    } catch (err) {
      console.error("Error fetching balance:", err);
    }
  };

  return (
    <div>
      <h2>Token Information</h2>
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
      <hr />
      <button onClick={fetchBalance}>Fetch My Balance</button>
      {balance && <p>Your Balance: {balance}</p>}
    </div>
  );
}
```

## Lesson 7: Sining Chain

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function tokenURI(uint256) view returns (string)",
  "function balanceOf(address) view returns (uint256)",
  "function tokenOfOwnerByIndex(address, uint256) view returns (uint256)",
  "function ownerOf(uint256) view returns (address)",
];

const CONTRACT_ADDRESS = process.env.REACT_APP_CONTRACT_ADDRESS;
const RPC_URL = process.env.REACT_APP_RPC_URL;

// Helper function to convert IPFS URLs
const convertToHttpUrl = (uri) => {
  if (!uri) return "/placeholder.png";
  if (uri.startsWith("http")) return uri;
  if (uri.startsWith("ipfs://")) {
    return uri.replace("ipfs://", "https://ipfs.io/ipfs/");
  }
  if (uri.startsWith("Qm") || uri.startsWith("bafy")) {
    return `https://ipfs.io/ipfs/${uri}`;
  }
  return uri;
};

export default function NFTGallery() {
  const [tokenId, setTokenId] = useState("");
  const [nft, setNft] = useState(null);
  const [ownedNFTs, setOwnedNFTs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchSingleNFT = async () => {
    try {
      setLoading(true);
      setError("");
      setNft(null);

      const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

      const uri = await contract.tokenURI(tokenId);
      const httpUri = convertToHttpUrl(uri);
      const response = await fetch(httpUri);
      const metadata = await response.json();

      setNft({
        name: metadata.name,
        description: metadata.description,
        image: convertToHttpUrl(metadata.image),
      });
    } catch (err) {
      setError("Failed to load NFT: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const fetchOwnedNFTs = async () => {
    try {
      setLoading(true);
      setError("");
      setOwnedNFTs([]);

      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

      const balance = await contract.balanceOf(account);
      const items = [];

      for (let i = 0; i < balance; i++) {
        const tokenId = await contract.tokenOfOwnerByIndex(account, i);
        const uri = await contract.tokenURI(tokenId);
        const httpUri = convertToHttpUrl(uri);
        const response = await fetch(httpUri);
        const metadata = await response.json();

        items.push({
          tokenId: tokenId.toString(),
          name: metadata.name,
          image: convertToHttpUrl(metadata.image),
        });
      }

      setOwnedNFTs(items);
    } catch (err) {
      setError("Failed to load collection: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h2>🎨 SiningChain NFT Gallery</h2>

      {/* Single NFT Viewer */}
      <div>
        <h3>View Single NFT</h3>
        <input
          type="number"
          placeholder="Token ID"
          value={tokenId}
          onChange={(e) => setTokenId(e.target.value)}
        />
        <button onClick={fetchSingleNFT} disabled={loading}>
          Load NFT
        </button>
        {nft && (
          <div>
            <img src={nft.image} alt={nft.name} style={{ maxWidth: 300 }} />
            <h4>{nft.name}</h4>
            <p>{nft.description}</p>
          </div>
        )}
      </div>

      {/* Owned NFTs Gallery */}
      <div>
        <h3>My Collection</h3>
        <button onClick={fetchOwnedNFTs} disabled={loading}>
          Load My NFTs
        </button>
        {ownedNFTs.length === 0 && !loading && <p>No NFTs found.</p>}
        <div style={{ display: "flex", gap: 16, flexWrap: "wrap" }}>
          {ownedNFTs.map((item, i) => (
            <div key={i} style={{ border: "1px solid #ccc", padding: 8 }}>
              <img src={item.image} alt={item.name} style={{ width: 150 }} />
              <p>{item.name}</p>
            </div>
          ))}
        </div>
      </div>

      {loading && <p>Loading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## Lesson 8: Send Tokens via UI

```javascript
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
```

## Lesson 9: Onchain To-Do List

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",
  "function createTask(string)",
  "function toggleDone(uint256)",
  "function deleteTask(uint256)",
];

const CONTRACT_ADDRESS = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState("");
  const [loading, setLoading] = useState(true);

  const loadTasks = async () => {
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

      const count = await contract.getTasksCount();
      const items = [];

      for (let i = 0; i < count; i++) {
        const [id, content, done] = await contract.tasks(i);
        if (content !== "") {
          items.push({ id: id.toNumber(), content, done });
        }
      }

      setTasks(items);
    } catch (err) {
      console.error("Error loading tasks:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadTasks();
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    if (!newTask.trim()) return;

    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.createTask(newTask);
      await tx.wait();

      setNewTask("");
      loadTasks();
    } catch (err) {
      console.error("Error creating task:", err);
    }
  };

  const handleToggle = async (taskId) => {
    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.toggleDone(taskId);
      await tx.wait();

      setTasks((prev) =>
        prev.map((t) => (t.id === taskId ? { ...t, done: !t.done } : t))
      );
    } catch (err) {
      console.error("Error toggling task:", err);
    }
  };

  if (loading) return <p>Loading tasks...</p>;

  return (
    <div>
      <h2>On-Chain To-Do List</h2>
      <form onSubmit={handleCreate}>
        <input
          value={newTask}
          onChange={(e) => setNewTask(e.target.value)}
          placeholder="New task..."
        />
        <button type="submit">Add</button>
      </form>
      <ul>
        {tasks.map((task) => (
          <li key={task.id}>
            <input
              type="checkbox"
              checked={task.done}
              onChange={() => handleToggle(task.id)}
            />
            <span
              style={{ textDecoration: task.done ? "line-through" : "none" }}
            >
              {task.content}
            </span>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

## Lesson 10: DAO Voting UI

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "function hasVoted(uint256, address) view returns (bool)",
  "function vote(uint256, bool)",
  "event Voted(address indexed voter, uint256 indexed proposalId, bool support)",
];

const DAO_ADDRESS = process.env.REACT_APP_DAO_ADDRESS;

export default function DAOVoting() {
  const [proposals, setProposals] = useState([]);
  const [userAddress, setUserAddress] = useState("");
  const [loading, setLoading] = useState(true);

  // Load proposals
  useEffect(() => {
    const loadProposals = async () => {
      try {
        const [account] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setUserAddress(account);

        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const contract = new ethers.Contract(DAO_ADDRESS, ABI, provider);

        const count = await contract.getProposalCount();
        const items = [];

        for (let i = 0; i < count; i++) {
          const [id, description, yes, no] = await contract.proposals(i);
          const voted = await contract.hasVoted(i, account);

          items.push({
            id: id.toNumber(),
            description,
            yes: yes.toNumber(),
            no: no.toNumber(),
            hasVoted: voted,
          });
        }

        setProposals(items);
      } catch (err) {
        console.error("Error loading proposals:", err);
      } finally {
        setLoading(false);
      }
    };

    loadProposals();
  }, []);

  // Real-time vote updates
  useEffect(() => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(DAO_ADDRESS, ABI, provider);

    const handleVote = (voter, proposalId, support) => {
      setProposals((prev) =>
        prev.map((p) =>
          p.id === proposalId.toNumber()
            ? {
                ...p,
                yes: support ? p.yes + 1 : p.yes,
                no: support ? p.no : p.no + 1,
              }
            : p
        )
      );
    };

    contract.on("Voted", handleVote);
    return () => contract.off("Voted", handleVote);
  }, []);

  const castVote = async (proposalId, support) => {
    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(DAO_ADDRESS, ABI, signer);

      const tx = await contract.vote(proposalId, support);
      await tx.wait();

      setProposals((prev) =>
        prev.map((p) =>
          p.id === proposalId
            ? {
                ...p,
                yes: support ? p.yes + 1 : p.yes,
                no: support ? p.no : p.no + 1,
                hasVoted: true,
              }
            : p
        )
      );
    } catch (err) {
      console.error("Error casting vote:", err);
    }
  };

  if (loading) return <p>Loading proposals...</p>;

  return (
    <div>
      <h2>🏛️ BarangayDAO Voting</h2>
      <p>
        Connected: {userAddress.slice(0, 6)}...{userAddress.slice(-4)}
      </p>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ border: "1px solid #ccc", padding: 16, margin: 8 }}
        >
          <h3>
            #{p.id}: {p.description}
          </h3>
          <p>
            👍 {p.yes} | 👎 {p.no}
          </p>
          {p.hasVoted ? (
            <span>You've voted</span>
          ) : (
            <div>
              <button onClick={() => castVote(p.id, true)}>Vote Yes</button>
              <button onClick={() => castVote(p.id, false)}>Vote No</button>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
```

## Lesson 11: Real Time Gas Fee Tracker

```javascript
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      try {
        // Task 1: Create the provider instance
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );

        // Task 2: Create the contract instance
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );

        // Task 3: Fetch base fee and update state
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
  return <p>Current Base Fee: {base.toString()} wei</p>;
}
```

## Lesson 12: DeFi Dashboard

```javascript
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
        const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

        if (!ethers.utils.isAddress(LP_ADDRESS)) {
          throw new Error("Invalid LP contract address");
        }

        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);

        const [r0, r1] = await lp.getReserves();
        const ts = await lp.getTotalSupply();
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

## Lesson 13: Multisig Transaction Initiator

```javascript
// ProposalList.js - Complete Solution
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
  "function confirmations(uint256, address) view returns (bool)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const wallet = new ethers.Contract(contractAddress, ABI, provider);

        const count = (await wallet.getTransactionCount()).toNumber();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [to, value, data, executed, numConfirmations] =
            await wallet.transactions(i);
          items.push({
            id: i,
            to,
            value: ethers.utils.formatEther(value),
            data: data.slice(0, 10) + "…",
            executed,
            numConfirmations: numConfirmations.toNumber(),
          });
        }
        setProposals(items);
      } catch (err) {
        setError(err.message);
      }
    }
    loadProposals();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Multisig Proposals</h3>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ borderBottom: "1px solid #ccc", padding: "8px 0" }}
        >
          <p>
            <strong>ID #{p.id}</strong>
          </p>
          <p>To: {p.to}</p>
          <p>Value: {p.value} ETH</p>
          <p>Data: {p.data}</p>
          <p>Confirmations: {p.numConfirmations}</p>
          <p>Executed: {p.executed ? "✅" : "❌"}</p>
        </div>
      ))}
    </div>
  );
}
```

## Lesson 14: Simulated Chain Oracle DApp

```javascript
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const relief = new ethers.Contract(CONTRACT, ABI, provider);

        const [ws, rel] = await Promise.all([
          relief.windSpeed(),
          relief.released(),
        ]);
        const bal = await provider.getBalance(CONTRACT);

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
      <p>
        Wind Speed: <strong>{wind}</strong> km/h
      </p>
      <p>
        Pool Balance: <strong>{balance}</strong> ETH
      </p>
      <p>
        Released:{" "}
        <strong>{released ? "✅ Funds Dispatched" : "❌ Pending"}</strong>
      </p>
    </div>
  );
}
```

## Lesson 15: Onchain Identity Viewer

```javascript
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
```

## Lesson 16: Escrow DApp

```javascript
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
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        // Task 1: Initialize provider and contract
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        const escrow = new ethers.Contract(ADDR, ABI, provider);

        // Task 2: Fetch all escrow data using Promise.all
        const [b, s, a, dep, rel] = await Promise.all([
          escrow.buyer(),
          escrow.seller(),
          escrow.amount(),
          escrow.deposited(),
          escrow.released(),
        ]);

        // Task 3: Update state with fetched data
        setBuyer(b);
        setSeller(s);
        setAmt(a);
        setDeposited(dep);
        setReleased(rel);
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (amt === null) return <p>Loading escrow stats…</p>;
  return (
    <div>
      <h3>Escrow Status</h3>
      <p>Buyer: {buyer}</p>
      <p>Seller: {seller}</p>
      <p>Amount: {ethers.utils.formatEther(amt)} ETH</p>
      <p>
        Status:{" "}
        {released
          ? "Released ✅"
          : deposited
          ? "Pending ⏳"
          : "Not Deposited ❌"}
      </p>
    </div>
  );
}
```

## Lesson 17: Multi Network Switch UI

```javascript
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
        // Task 1: Create provider based on wallet availability
        if (window.ethereum) {
          provider = new ethers.providers.Web3Provider(window.ethereum);
          await window.ethereum.request({ method: "eth_requestAccounts" });
        } else {
          provider = new ethers.providers.JsonRpcProvider(RPC);
        }

        // Task 2: Fetch chain ID and map to friendly name
        contract = new ethers.Contract(CONTRACT, ABI, provider);
        const idBN = await contract.getChainId();
        const id = idBN.toNumber();
        setChainId(id);
        setChainName(NAMES[id] || "Unknown");
      } catch (err) {
        setError(err.message);
      }
    }

    // Task 3: Define handler for chainChanged event
    function handleChange(chainHex) {
      const id = parseInt(chainHex, 16);
      setChainId(id);
      setChainName(NAMES[id] || "Unknown");
    }

    loadChain();

    // Subscribe to chainChanged event
    if (window.ethereum) {
      window.ethereum.on("chainChanged", handleChange);
    }

    // Cleanup listener on unmount
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

## Lesson 18: NFT Minting UI with Image Preview

```javascript
import React from "react";

export default function NFTPreview({ title, description, file }) {
  // Task 1: Handle missing file case
  if (!file) {
    return <p>Please upload an image to preview your NFT.</p>;
  }

  // Task 2: Create object URL for image preview
  const imageUrl = URL.createObjectURL(file);

  // Task 3: Build metadata object and render preview UI
  const metadata = {
    name: title || "Untitled",
    description: description || "",
    image: imageUrl,
  };

  return (
    <div style={{ border: "1px solid #ccc", padding: 16 }}>
      <h4>Image Preview</h4>
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

## Lesson 19: Contract Deployment Simulator

```javascript
import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";

export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function deploy() {
    try {
      setError("");
      setLoading(true);

      // Task 1: Connect to MetaMask and get signer
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      // Task 2: Create ContractFactory with artifact
      const factory = new ethers.ContractFactory(
        HelloWorldArtifact.abi,
        HelloWorldArtifact.bytecode,
        signer
      );

      // Task 3: Deploy contract and wait for confirmation
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

## Lesson 20: Layer Zero Inspired UI

```javascript
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

      // Task 1: Connect to MetaMask and create contract instance
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );

      // Task 2: Call lockTokens() with ETH value
      const tx = await bridge.lockTokens({
        value: ethers.utils.parseEther(amt),
      });
      const receipt = await tx.wait();

      // Task 3: Parse Locked event and invoke callback
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
