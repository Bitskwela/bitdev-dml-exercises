# Answer Keys for Chapter 3: Solidity Mini Projects

## Lesson 1: Liquidity lockdown

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LiquidityLocker {
    address public owner;
    uint256 public lockEnd;
    mapping(address => uint256) public deposits;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");
        deposits[msg.sender] += msg.value;
        lockEnd = block.timestamp + 60; // 1 minute lock
    }

    function withdraw() external {
        require(block.timestamp >= lockEnd, "Still locked");
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No funds");
        deposits[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
```

## Lesson 2: Staking the future

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract SimpleStaker {
    IERC20 public stakingToken;
    uint256 public lockDuration = 60;

    struct Stake {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Stake) public stakes;

    constructor(address _token) {
        stakingToken = IERC20(_token);
    }

    function stake(uint256 amount) public {
        require(amount > 0, "Nothing to stake");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakes[msg.sender] = Stake(amount, block.timestamp + lockDuration);
    }

    function unstake() public {
        Stake memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "Nothing staked");
        require(block.timestamp >= userStake.unlockTime, "Still locked");

        uint256 reward = (userStake.amount * 110) / 100;
        delete stakes[msg.sender];

        stakingToken.transfer(msg.sender, reward);
    }
}
```

## Lesson 3: Iloilo lending protocol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayLending {
    struct LoanRequest {
        address borrower;
        uint256 amount;
        string reason;
        bool isFunded;
        address lender;
    }

    uint256 public loanCounter;
    mapping(uint256 => LoanRequest) public loans;

    event LoanRequested(
        uint256 loanId,
        address borrower,
        uint256 amount,
        string reason
    );
    event LoanFunded(uint256 loanId, address lender);

    function requestLoan(uint256 amount, string memory reason) public {
        loanCounter++;
        loans[loanCounter] = LoanRequest({
            borrower: msg.sender,
            amount: amount,
            reason: reason,
            isFunded: false,
            lender: address(0)
        });

        emit LoanRequested(loanCounter, msg.sender, amount, reason);
    }

    function fundLoan(uint256 loanId) public payable {
        LoanRequest storage loan = loans[loanId];

        require(!loan.isFunded, "Loan already funded");
        require(msg.value == loan.amount, "Incorrect amount");

        loan.isFunded = true;
        loan.lender = msg.sender;

        payable(loan.borrower).transfer(msg.value);
        emit LoanFunded(loanId, msg.sender);
    }
}
```

## Lesson 4: Security protection

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayAidVault {
    mapping(address => uint256) public claimable;
    address public owner;

    event AidDeposited(
        address indexed donor,
        address indexed recipient,
        uint256 amount
    );
    event AidClaimed(address indexed recipient, uint256 amount);
    event EmergencyWithdrawn(uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function depositAid(address recipient) public payable {
        require(msg.value > 0, "Cannot send 0 ETH");
        claimable[recipient] += msg.value;
        emit AidDeposited(msg.sender, recipient, msg.value);
    }

    function claimAid() public {
        uint256 amount = claimable[msg.sender];
        require(amount > 0, "Nothing to claim");

        claimable[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit AidClaimed(msg.sender, amount);
    }

    function emergencyWithdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");
        payable(owner).transfer(balance);
        emit EmergencyWithdrawn(balance);
    }
}
```

## Lesson 5: Tokenized sari-sari store

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SariSariToken is ERC20 {
    address public owner;
    uint256 public constant MAX_SUPPLY = 50000 * 1e18;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() ERC20("SariSari Token", "SST") {
        owner = msg.sender;
        _mint(owner, 10000 * 1e18); // Mint ₱10,000 worth
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds cap");
        _mint(to, amount);
    }
}
```

