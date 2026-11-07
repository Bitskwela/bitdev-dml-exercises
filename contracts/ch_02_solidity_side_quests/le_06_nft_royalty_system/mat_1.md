# Side Quest 6: NFT Royalty System

![NFT Royalty System](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+6.0+-+COVER.png)

# Scenario:

After Hackana's devastating attacks on Web3 infrastructures, the NFT marketplace of San Juan collapsed — leaving creators unrewarded. Hackana’s minions tampered with the royalty payout logic, stripping artists of their deserved income.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+6.1.png)

Now, Neri — **San Juan’s top software engineer** — must restore fairness to the creative economy. With her skill, she will secure royalties for every NFT trade, ensuring creators thrive once again.

# Mission Brief

- **Time Allotment**: 20 minutes
- **Solidity Topics Covered**: ERC721, Royalties, Transfers.

> **Heads up: `transfer` is fine for learning, not for production.**
> This lesson uses `payable(address).transfer(amount)` because it is short and reverts on failure. It forwards only 2300 gas, so it fails for recipients that are smart contract wallets (multisigs, smart accounts) and can leave their funds stuck. Real contracts send Ether with `call{value: amount}("")` plus a success check, protected by checks-effects-interactions or `nonReentrant`. You will see exactly how in Course 1, Lesson 30.
