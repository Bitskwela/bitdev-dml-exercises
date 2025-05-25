## Smart Contract Activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SanJuanToken {
    string public name = "SanJuanToken";
    string public symbol = "SJT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Not enough balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        // TODO: Allow a spender to spend tokens on behalf of the owner
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        // TODO: Use allowance mechanism to let approved users send tokens on behalf of others
    }
}
```

## Todo list:

- Complete the `approve()` so spender can be authorized.

  ```solidity
      function approve(address _spender, uint256 _value) public returns (bool) {
          allowance[msg.sender][_spender] = _value;
          return true;
      }
  ```

- Complete the `transferFrom()` function so authorized users can send tokens on behalf of others, and ensure the `transferFrom()` function updates both balances and allowances.

  ```solidity
      function transferFrom(address _from, address _to, uint256 _value)
      public returns (bool) {
          require(balanceOf[_from] >= _value, "Not enough balance");
          require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

            balanceOf[_from] -= _value;
            balanceOf[_to] += _value;
            allowance[_from][msg.sender] -= _value;
            return true;
        }
  ```

### Brief Explanation:

- `approve`: Authorizes a spender to spend a certain number of tokens on behalf of the token owner.

- `transferFrom`: Enables a third party (like a smart contract or dApp) to transfer tokens from one address to another, using the allowance mechanism.

- This mimics how DeFi protocols and marketplaces manage token payments securely.
