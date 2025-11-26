# Answer Keys for Chapter 1: Basic Solidity

## Lesson 1: Waking up to chaos

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkePay {
    string public vendorName;

    uint256 public totalPayments;

    string public payerName;

    function recordPayment(
        string memory _vendorName,
        uint256 _amount,
        string memory _payee
    ) public {
        vendorName = _vendorName;
        totalPayments = _amount;
        payerName = _payee;
    }
}
```

## Lesson 2: Palenke troubles

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeLedger {
    string public vendorName;
    uint256 public totalSales;
    bool public transactionStatus;

    mapping(address => uint256) public vendorSales;

    function recordSale(
        address _vendor,
        string memory _vendorName,
        uint256 _saleAmount
    ) public {
        vendorName = _vendorName;
        totalSales += _saleAmount;
        vendorSales[_vendor] += _saleAmount;
        transactionStatus = true;
    }

    function isTransactionSuccessful() public view returns (bool) {
        return transactionStatus;
    }
}
```

## Lesson 3: Jeepney fare disputes

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JeepneyFareSystem {
    mapping(address => bool) public hasPaid;

    uint256 public baseFare = 13;

    function calculateFare(uint256 distance) public view returns (uint256) {
        return baseFare + (distance * 2);
    }

    function payFare(uint256 distance) public payable {
        uint256 requiredFare = calculateFare(distance);
        require(msg.value == requiredFare, "Incorrect fare amount.");
        hasPaid[msg.sender] = true;
    }

    function checkPaymentStatus(address passenger) public view returns (bool) {
        return hasPaid[passenger];
    }

    function verifyFare(
        uint256 distance,
        uint256 paidAmount
    ) private view returns (bool) {
        return paidAmount == calculateFare(distance);
    }
}
```

## Lesson 4: Palengke Calculator

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PalengkeCalculator {
    function calculateTotal(
        uint256 pricePerUnit,
        uint256 quantity
    ) public pure returns (uint256) {
        return pricePerUnit * quantity;
    }

    function calculateChange(
        uint256 totalCost,
        uint256 payment
    ) public pure returns (uint256) {
        require(payment >= totalCost, "Insufficient payment.");
        return payment - totalCost;
    }

    function applyDiscount(
        uint256 totalCost,
        uint256 discountPercent
    ) public pure returns (uint256) {
        require(discountPercent <= 100, "Invalid discount percentage.");
        return totalCost - ((totalCost * discountPercent) / 100);
    }

    function splitBill(
        uint256 totalCost,
        uint256 groupSize
    ) public pure returns (uint256) {
        require(groupSize > 0, "Group size must be greater than zero.");
        return totalCost / groupSize;
    }
}
```

## Lesson 5: Battle Against Hackana

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {
    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender;
    }

    function donate(uint256 amount) public payable {
        require(amount > 0, "Donation must be greater than zero");
        require(msg.value == amount, "Insufficient Ether provided");
        totalDonations += amount;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == fundOwner, "Only the owner can withdraw funds");
        require(amount <= totalDonations, "Not enough funds");
        totalDonations -= amount;
        payable(fundOwner).transfer(amount);
    }
}
```

## Lesson 6: Protecting the Donation Fund

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureFund {
    address public owner;
    uint256 public totalDonations;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");
        totalDonations += msg.value;
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
```

## Lesson 7: Neri and the Assertive Checkpoint

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract HackanaDefense {
    uint256 public criticalData;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function updateCriticalData(uint256 _newData) public {
        criticalData = _newData;
        assert(criticalData >= 0);
    }

    function restrictedUpdate(uint256 _newData) public {
        if (msg.sender != owner) {
            revert("Access denied: Only the owner can update critical data.");
        }
        criticalData = _newData;
    }
}
```

## Lesson 8: Mapping the Problem Away

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AntiHackanaLedger {
    mapping(address => uint256) public userBalances;

    function updateBalance(address _user, uint256 _newBalance) public {
        userBalances[_user] = _newBalance;
    }

    function getBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }
}
```

## Lesson 9: Structing the Defense

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomerRegistry {
    struct Customer {
        string name;
        address walletAddress;
        uint256 balance;
    }

    mapping(address => Customer) public customers;

    function addCustomer(string memory _name, uint256 _balance) public {
        customers[msg.sender] = Customer({
            name: _name,
            walletAddress: msg.sender,
            balance: _balance
        });
    }

    function getCustomer(
        address _walletAddress
    ) public view returns (string memory, address, uint256) {
        Customer memory customer = customers[_walletAddress];
        return (customer.name, customer.walletAddress, customer.balance);
    }
}
```

## Lesson 10: Array and the Rising Chaos

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeTransactions {
    uint256[] public payments;

    function recordPayment(uint256 _amount) public {
        payments.push(_amount); // Add the payment to the array
    }

    function getTotalPayments() public view returns (uint256) {
        return payments.length; // Return the number of elements in the array
    }

    function getPayment(uint256 _index) public view returns (uint256) {
        require(_index < payments.length, "Invalid index.");
        return payments[_index]; // Return the payment at the given index
    }
}
```

## Lesson 11: Constructors and Neri's Next Challenge

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayProgram {
    string public programName;
    uint256 public startingBalance;

    constructor(string memory _programName, uint256 _startingBalance) {
        programName = _programName;
        startingBalance = _startingBalance;
    }

    function getProgramDetails() public view returns (string memory, uint256) {
        return (programName, startingBalance);
    }
}
```

## Lesson 12: Events and the Barangay Fund

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayFund {
    uint256 public totalFunds;
    event FundUpdated(uint256 newAmount, address updatedBy);

    function depositFunds(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        totalFunds += amount;

        emit FundUpdated(totalFunds, msg.sender);
    }
}
```

## Lesson 13: Fallback and Receive Functions

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayWallet {
    uint256 public totalReceived;

    event InvalidCall(address sender, uint256 value, bytes data);

    receive() external payable {
        totalReceived += msg.value;
    }

    fallback() external payable {
        emit InvalidCall(msg.sender, msg.value, msg.data);
    }
}
```

## Lesson 14: Pure and View Functions

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {
    uint256 public certificationFee = 100; // Fee for one certification

    function getCertificationFee() public view returns (uint256) {
        return certificationFee;
    }

    function calculateTotalCost(
        uint256 numberOfCertifications
    ) public pure returns (uint256) {
        return numberOfCertifications * 100;
    }
}
```

## Lesson 15: Global Variables

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionTracker {
    address public caller;
    uint256 public transactionTime;

    function updateTransaction() public {
        caller = msg.sender;
        transactionTime = block.timestamp;
    }
}
```

## Lesson 16: Ether and Wei

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherConverter {
    function etherToWei(uint256 etherAmount) public pure returns (uint256) {
        return etherAmount * 1 ether;
    }

    function weiToEther(uint256 weiAmount) public pure returns (uint256) {
        return weiAmount / 1 ether;
    }
}
```

## Lesson 17: Storage vs Memory

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataOptimization {
    string public storedMessage = "Stored permanently";

    function updateMessage(string memory tempMessage) public {
        storedMessage = tempMessage;
    }

    function compareStorageAndMemory() public view returns (string memory) {
        string memory tempMessage = storedMessage;
        return tempMessage;
    }
}
```

## Lesson 18: Calldata - The Art of Efficient Communication

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {
    uint256 public certificationFee = 100; // Fee for one certification

    function getCertificationFee() public view returns (uint256) {
        return certificationFee;
    }

    function calculateTotalCost(
        uint256 numberOfCertifications
    ) public pure returns (uint256) {
        return numberOfCertifications * 100;
    }
}
```

## Lesson 19: Solidity's Inheritance

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract BaseContract {
    string public organizationName;

    function setOrganizationName(string memory name) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        organizationName = name;
    }
}

// Child contract inheriting from BaseContract
contract DerivedContract is BaseContract {
    uint256 public fundBalance;

    function depositFunds(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        fundBalance += amount;
    }
}
```

## Lesson 20: Unlocking the Payable Arsenal

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherReceiver {
    event PaymentReceived(address indexed from, uint256 amount);

    function receivePayment() public payable {
        emit PaymentReceived(msg.sender, msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
```

## Lesson 21: Interfaces in Solidity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITransaction {
    function deposit(uint256 amount) external payable;

    function withdraw(uint256 amount) external;

    function checkBalance() external view returns (uint256);
}

contract Marketplace is ITransaction {
    mapping(address => uint256) private balances;

    function deposit(uint256 amount) external payable override {
        require(msg.value == amount, "Amount does not match sent Ether");

        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function checkBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}
```

## Lesson 22: Libraries of Hope

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLibrary {
    function calculatePercentage(
        uint256 base,
        uint256 percent
    ) internal pure returns (uint256) {
        return (base * percent) / 100;
    }
}

contract HackanaDefense {
    string public city = "San Juan City";

    function calculateFee(
        uint256 transactionAmount,
        uint256 feePercent
    ) public pure returns (uint256) {
        return MathLibrary.calculatePercentage(transactionAmount, feePercent);
    }
}
```

## Lesson 23: File Imports

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MathLibrary.sol";

contract Calculator {
    function calculateSum(uint256 x, uint256 y) public pure returns (uint256) {
        return MathLibrary.add(x, y);
    }

    function calculateProduct(
        uint256 x,
        uint256 y
    ) public pure returns (uint256) {
        return MathLibrary.multiply(x, y);
    }
}
```

## Lesson 24: Understanding OpenZeppelin

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HackanaDefenseToken is ERC20 {
    constructor() ERC20("DefenseToken", "DEF") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
```

## Lesson 25: The Dawn of Tokenization

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SanJuanCityToken is ERC20 {
    constructor() ERC20("SanJuanToken", "SJC") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
```

## Lesson 26: The ERC721 Token Standard

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import ERC721 from OpenZeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DigitalArtToken is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;

    constructor()
        ERC721("DigitalArtToken", "DAT")
        Ownable(msg.sender)
        ERC721URIStorage()
    {}

    function mintArt(
        address recipient,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        _tokenIds++;
        uint256 newItemId = _tokenIds;

        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
```

## Lesson 27: Custom Error and Error Handling

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

error UnauthorizedAccess(address caller);

error InsufficientFunds(uint256 requested, uint256 available);

contract CustomErrorExample {
    address public owner;
    uint256 public totalBalance;

    constructor() {
        owner = msg.sender;
        totalBalance = 1000;
    }

    function withdraw(uint256 amount) public {
        if (msg.sender != owner) {
            revert UnauthorizedAccess(msg.sender);
        }

        if (amount > totalBalance) {
            revert InsufficientFunds(amount, totalBalance);
        }

        totalBalance -= amount;
    }

    function checkBalance() public view returns (uint256) {
        return totalBalance;
    }
}
```

## Lesson 28: ERC1155 Token Standard

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiAsset is ERC1155, Ownable {
    uint256 public constant GOLD = 1; // Fungible token
    uint256 public constant ARTIFACT = 2; // Non-fungible token

    constructor()
        ERC1155("https://api.example.com/metadata/{id}.json")
        Ownable(msg.sender)
    {
        _mint(msg.sender, GOLD, 1000, ""); // Mint 1000 Gold Coins
        _mint(msg.sender, ARTIFACT, 1, ""); // Mint 1 Special Artifact
    }

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(to, id, amount, data);
    }
}
```

## Lesson 29: Upgradable Smart Contracts

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserRegistryV1 {
    mapping(address => string) public userNames;

    function initialize() public /*initializer*/ {
        // Initialization logic (for now, nothing needed)
    }

    // Function to register a user
    function registerUser(string memory name) public {
        userNames[msg.sender] = name;
    }

    // Function to get the name of a registered user
    function getUser(address user) public view returns (string memory) {
        return userNames[user];
    }
}

// Version 2 - Upgrade to allow updating user names
contract UserRegistryV2 is UserRegistryV1 {
    // Function to update user name
    function updateUser(string memory newName) public {
        userNames[msg.sender] = newName;
    }
}
```

## Lesson 30: Writing Secured Smart Contracts

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin utilities for security
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureDonation is Ownable, ReentrancyGuard {
    constructor() Ownable(msg.sender) ReentrancyGuard() {}

    // State variable to track total donations
    uint256 public totalDonations;

    // Mapping to store donations per user
    mapping(address => uint256) public donations;

    // Function to accept donations
    function donate() external payable nonReentrant {
        require(msg.value > 0, "Donation must be greater than zero.");

        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }

    function withdraw() external onlyOwner nonReentrant {
        require(totalDonations > 0, "No funds to withdraw.");

        // Transfer all funds to the owner
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Withdrawal failed.");
    }
}
```



