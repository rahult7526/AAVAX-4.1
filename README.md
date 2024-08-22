# Game Contracts

This repository contains Solidity smart contracts for a simple game that includes various features such as battling, exploring, trading, and an in-game currency (ERC-20 token).

## Contracts

1. **Battle.sol**
   - **Purpose:** Allows players to register and engage in battles. The battle logic determines the winner based on attack power.
   - **Key Functions:**
     - `registerPlayer(uint256 _health, uint256 _attackPower)`: Registers a player with specified health and attack power.
     - `battle(address _opponent)`: Initiates a battle between the sender and an opponent. The contract determines the winner based on attack power.
   - **Dependencies:** None.

2. **Exploration.sol**
   - **Purpose:** Enables players to explore and earn exploration points.
   - **Key Functions:**
     - `explore()`: Increases the player's exploration points by 1.
     - `getPoints()`: Returns the total exploration points the player has earned.
   - **Dependencies:** None.

3. **Trading.sol**
   - **Purpose:** Facilitates trading of items between players.
   - **Key Functions:**
     - `trade(address _to, uint256 _amount)`: Trades a specified amount of items from the sender to the recipient.
     - `addItem(uint256 _amount)`: Adds a specified amount of items to the sender's inventory.
     - `getItems()`: Returns the total number of items the sender possesses.
   - **Dependencies:** None.

4. **GameToken.sol**
   - **Purpose:** Implements an ERC-20 token called "GameToken" (`GT`) that can be used as an in-game currency.
   - **Key Functions (Inherited from ERC-20):**
     - `balanceOf(address account)`: Returns the balance of tokens held by the specified account.
     - `transfer(address recipient, uint256 amount)`: Transfers tokens from the sender's account to the recipient.
     - `approve(address spender, uint256 amount)`: Approves `spender` to spend `amount` of tokens on behalf of the sender.
     - `transferFrom(address sender, address recipient, uint256 amount)`: Transfers tokens on behalf of the owner based on allowance.
     - `totalSupply()`: Returns the total supply of tokens in existence.
   - **Dependencies:** OpenZeppelin's ERC-20 implementation.

## Getting Started

### Prerequisites

- [Remix IDE](https://remix.ethereum.org/)
- [MetaMask](https://metamask.io/) (for interacting with the contract)

### Deploying Contracts

1. **Open Remix IDE:**
   - Go to [Remix IDE](https://remix.ethereum.org/).

2. **Create a New File:**
   - Create a new Solidity file (`.sol`) in the Remix IDE for each contract (e.g., `Battle.sol`, `Exploration.sol`, `Trading.sol`, `GameToken.sol`).

3. **Copy and Paste Contract Code:**
   - Copy the code for each contract and paste it into the respective file.

4. **Compile Contracts:**
   - Select the appropriate Solidity version (e.g., `0.8.9`) and compile each contract by clicking the "Compile" button in Remix.

5. **Deploy Contracts:**
   - Go to the "Deploy & Run Transactions" tab.
   - Select the contract you want to deploy from the dropdown.
   - For `GameToken`, enter the initial supply (e.g., `1000000`) before deploying.
   - Click "Deploy" to deploy the contract.

### Interacting with the Contracts

- **Battle.sol:**
  - **Register a Player:** Use `registerPlayer(_health, _attackPower)` to register a player.
  - **Initiate a Battle:** Call `battle(_opponent)` to start a battle with another player.

- **Exploration.sol:**
  - **Explore:** Use `explore()` to earn exploration points.
  - **Check Points:** Call `getPoints()` to view your total exploration points.

- **Trading.sol:**
  - **Add Items:** Use `addItem(_amount)` to add items to your inventory.
  - **Trade Items:** Use `trade(_to, _amount)` to trade items with another player.
  - **Check Items:** Call `getItems()` to see the total items you possess.

- **GameToken.sol:**
  - **Check Balance:** Call `balanceOf(_address)` to check the token balance of any address.
  - **Transfer Tokens:** Use `transfer(_to, _amount)` to transfer tokens to another address.
  - **Approve Tokens:** Use `approve(_spender, _amount)` to allow another address to spend tokens on your behalf.
  - **Transfer From:** Use `transferFrom(_from, _to, _amount)` to transfer tokens from one address to another using allowance.

## Additional Information

- **OpenZeppelin Dependency:** The `GameToken.sol` contract uses OpenZeppelin's ERC-20 implementation. Ensure that the OpenZeppelin package is installed or properly imported in Remix.

- **Testing:** It is recommended to test these contracts on a test network (e.g., Ropsten, Rinkeby) before deploying to the main Ethereum network.

- **MetaMask:** Connect MetaMask to Remix to interact with your deployed contracts.

## License

This project is licensed under the MIT License 
# AUTHOR
RAHUL TIWARY (rahult7526@gmail.com)
