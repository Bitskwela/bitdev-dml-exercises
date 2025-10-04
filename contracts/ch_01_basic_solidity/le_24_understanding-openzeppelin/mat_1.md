# Understanding OpenZeppelin

![24.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_24_understanding-openzeppelin/24.0%20-%20COVER.png)

## Scene

After tirelessly building strategies against Hackana, Neri stumbles upon a repository of tools shared by blockchain protectors worldwide—the _OpenZeppelin_ library.

It’s a treasure trove of reusable, battle-tested contracts that can help her implement security protocols faster.

Eager to level up her defenses, Neri realizes that OpenZeppelin might hold the secret to countering Hackana's next big attack.

### Solidity Topics: What is OpenZeppelin

![24.1 - OpenZeppelin](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_24_understanding-openzeppelin/24.1.png)

**OpenZeppelin** is a widely-used framework for secure smart contract development. It offers:

- **Prebuilt Contracts**: Like ERC20, ERC721 (NFTs), Access Control, etc.
- **Security**: Built with audited, secure code to reduce vulnerabilities.
- **Reusable Libraries**: Save time by using pre-tested implementations.
- **Customization**: Extend and adapt contracts to meet specific needs.

### Why and when to use OpenZeppelin

- ERC Standards: When building tokens (ERC20, ERC721, ERC1155).
- Access Control: To manage user permissions with roles.
  Upgradeable Contracts: For deploying proxies and upgrade patterns.
- Safe Math: To avoid arithmetic overflow/underflow bugs (built into Solidity >=0.8).
- Security: To leverage trusted implementations for secure operations.

### Example Syntax: How to use OpenZeppelin Contracts

- Importing the contracts – Pulling in OpenZeppelin’s ERC20 implementation

  ```solidity
  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  ```

- Extending contracts

  ```solidity
    contract MyToken is ERC20 {
        constructor() ERC20("MyToken", "MTK") {
            _mint(msg.sender, 1000 * 10 ** decimals());
        }
    }
  ```

- Using the Ownable - Access Control contract example

  ```solidity
    import "@openzeppelin/contracts/access/Ownable.sol";

    contract SecureContract is Ownable {
            function restrictedAction() public onlyOwner {
                // Only the contract owner can call this function
            }
        }
  ```
