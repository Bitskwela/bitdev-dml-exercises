# Chapter 4 Instructor Index: dApps

This file is an index, not an answer key. The answers live in each lesson's `act_1.answer.js`, and
that file plus the hidden test `act_1.t.js` are ground truth. No code is copied here on purpose, so
this page cannot drift from what is actually graded.

**How Chapter 4 is graded.** Every lesson is a React component (`spec.json` has
`"runtime": "react-jsx"`, `"ethers": "6"`). The hidden test mounts the learner's component against a
mocked wallet and chain (`contracts/harness/`) and asserts behaviour, never source text, so any
correct implementation passes whatever it names its variables. Check a lesson locally with:

```bash
node scripts/check-dapps.js contracts/ch_04_dapps/le_01_connect_my_metamask   # one lesson
node scripts/check-dapps.js                                                   # every react-jsx lesson
```

The gate requires the answer to pass its test and the starter (`act_1.js`) to fail it.

All answers use **ethers v6** (`ethers.BrowserProvider`, `ethers.JsonRpcProvider`,
`ethers.formatUnits`, `ethers.parseEther`, `waitForDeployment`). If a learner pastes v5 code
(`ethers.providers.Web3Provider`, `ethers.utils.*`, `.deployed()`), that is the bug. <!-- v5-ok -->

| Lesson | Answer file | Key concept | Graded behaviours (from `act_1.t.js`) |
| --- | --- | --- | --- |
| 01 Connect My MetaMask | `le_01_connect_my_metamask/act_1.answer.js` | Detect `window.ethereum` and request accounts with `eth_requestAccounts` | Prompts to install MetaMask when no wallet; shows Connect when a wallet exists; requests accounts on click; stores and shows the account; hides Connect once connected |
| 02 Read Smart Contract Data | `le_02_read_smart_contract_data/act_1.answer.js` | Read-only contract calls through a `JsonRpcProvider`, no wallet needed | Reads `name`, `symbol`, `totalMinted` on mount; uses a read-only provider; renders the values; converts the `uint256` instead of rendering a bigint; reads `tokenURIs(tokenId)` on click and shows it |
| 03 Triggering a Function | `le_03_triggering_a_function/act_1.answer.js` | A state-changing call needs a signer and a mined receipt | Renders a Vote control; requests accounts first; builds a `BrowserProvider` and awaits its signer; sends the proposal to `vote()`; waits for the receipt; notifies the parent; shows the confirmed state |
| 04 Event Listeners in the Frontend | `le_04_event_listeners_in_the_frontend/act_1.answer.js` | Subscribe to a contract event in `useEffect` and unsubscribe in cleanup | Shows a waiting state; subscribes to `WinnerPicked` on mount; renders the winner; keeps history newest first, capped at five; unsubscribes on cleanup |
| 05 Sign-In with Wallet Experience | `le_05_sign_in_with_wallet_experience/act_1.answer.js` | Passwordless sign-in: sign a nonce message, verify it against the contract | Opens on a Connect step; warns when MetaMask is missing; resolves the signer's address; asks the signer to sign; message includes a nonce; verifies against the contract; unlocks the dashboard on success |
| 06 Token Tracker | `le_06_token_tracker/act_1.answer.js` | ERC-20 metadata reads and `formatUnits` with the token's decimals | Reads `name`, `symbol`, `decimals` on mount and renders them; skips reads for an invalid address; connects and reads the caller's balance; formats the balance with the token's decimals |
| 07 Sining Chain | `le_07_sining_chain/act_1.answer.js` | NFT metadata via `tokenURI`, IPFS gateway rewrite, enumerating owned tokens | Reads `tokenURI`; converts `ipfs://` to a gateway URL before fetching; renders the metadata; walks `balanceOf` and `tokenOfOwnerByIndex`; renders every owned NFT; shows an empty state first |
| 08 Send Tokens via UI | `le_08_send_tokens_via_ui/act_1.answer.js` | Validate input, scale with `parseUnits`, send `transfer`, wait for the receipt | Renders recipient, amount and submit; rejects an invalid address and a zero or negative amount; reads decimals and scales the amount; waits for the receipt and reports success; shows the tx hash; prevents the form reload |
| 09 On-Chain To-Do List | `le_09_onchain_to_do_list/act_1.answer.js` | Indexed reads (count, then each item) plus write transactions | Reads the task count then each task; renders content and done state; creates a task from the form; waits for the receipt; ignores an empty submission; toggles a task from its checkbox |
| 10 DAO Voting UI | `le_10_dao_voting_ui/act_1.answer.js` | Per-proposal reads, per-user `hasVoted`, live tallies from an event | Reads count, each proposal and each vote status; renders proposals and tallies; hides vote buttons once voted; sends id and side; waits for the receipt; subscribes to `Voted` and unsubscribes on cleanup |
| 11 Gas Fee Checker | `le_11_real_time_gas_fee_tracker/act_1.answer.js` | Public data through a read-only provider, with loading and error states | Uses a read-only provider; reads the base fee from the contract; renders it; clears the loading state; labels the value |
| 12 DeFi Dashboard | `le_12_defi_dashboard/act_1.answer.js` | Unpacking a tuple return (`getReserves`) for a liquidity pool view | Uses a read-only provider; reads both reserves and total supply; unpacks the reserves tuple; renders total supply; clears the loading state |
| 13 Multisig Proposal Viewer | `le_13_multisig_transaction_initiator/act_1.answer.js` | Listing multisig proposals and showing wei as ether with `formatEther` | Reads the transaction count then each transaction; renders recipients; shows value in ether; shows confirmation counts; marks executed vs pending |
| 14 Simulated Chain Oracle dApp | `le_14_simulated_chain_oracle_dapp/act_1.answer.js` | Reading an oracle-fed value, and a contract's ETH balance from the provider | Reads wind speed and release flag; reads the pool balance from the provider, not the contract; renders wind speed and balance in ether; reports dispatched funds |
| 15 On-Chain Identity Viewer | `le_15_onchain_identity_viewer/act_1.answer.js` | Profile tuple for the connected address, indexed credentials, live updates | Connects to learn the address; reads and renders the profile tuple; reads one credential per reported count and renders all; subscribes to `ProfileUpdated` and removes it on cleanup; clears loading |
| 16 Escrow Status Viewer | `le_16_escrow_dapp/act_1.answer.js` | Reading every escrow field in parallel and deriving a status | Reads every escrow field; uses a read-only provider; renders both parties; shows the amount in ether; reports Pending when deposited but not released |
| 17 Network Detector | `le_17_multi_network_switch_ui/act_1.answer.js` | Chain detection, wallet `chainChanged` events, read-only fallback | Uses the wallet provider when present and a read-only one when not; reads the chain id; renders id and friendly name; subscribes to `chainChanged`, updates on switch, removes the listener on cleanup |
| 18 NFT Image Preview | `le_18_nft_minting_ui_with_image_preview/act_1.answer.js` | Local image preview with `URL.createObjectURL` and NFT metadata shape | Asks for an image when none chosen; never builds a URL from a missing file; creates a preview URL and renders it; renders title and description; shows metadata JSON with name, description, image; falls back to Untitled |
| 19 Contract Deployment Simulator | `le_19_contract_deployment_simulator/act_1.answer.js` | Deploying from the browser with `ContractFactory` and `waitForDeployment` | Disables Deploy until a greeting is entered; awaits a signer; builds a factory from abi and bytecode; passes the greeting to the constructor; waits for mining; hands the address to `onDeployed` |
| 20 LayerZero Inspired UI | `le_20_layer_zero_inspired_ui/act_1.answer.js` | A payable lock call with `parseEther`, reading an id from the `Locked` event | Bridge disabled until a positive amount; confirms before signing; awaits a signer; sends the amount as ETH value in wei; waits for the receipt; reads the transfer id from `Locked`; returns to idle |

When a lesson's test changes, update its row from the new test names. Never edit an answer or a
test to match this page.
