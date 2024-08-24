# Project Setup Guide

This guide will walk you through setting up and deploying the `Vault.sol` and `ERC20.sol` smart contracts on an Avalanche subnet using WSL and the Avalanche CLI.

## Prerequisites

1. **Windows Subsystem for Linux (WSL)**
   - Ensure you have WSL installed and set up on your system. If you haven't installed it yet, follow the [Microsoft guide](https://docs.microsoft.com/en-us/windows/wsl/install) to install WSL.

2. **Install Avalanche CLI**
   - Open your WSL terminal and run the following command to install the Avalanche CLI:
     ```sh
     curl -sSfL https://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s
     ```

## Steps to Deploy

### 1. Create a Subnet

After installing the Avalanche CLI, you need to create a subnet. Run the following command:

```sh
avalanche subnet create mysubnet
Note: Replace mysubnet with your desired subnet name.
```

## 2. Deploy the Subnet
Deploy the subnet you just created with the following command:

```sh
Copy code
avalanche subnet deploy mysubnet
Note: Ensure the subnet name matches the one you created earlier.
```
## 3. Configuration During Creation
When prompted with configuration questions during the creation process, use the following parameters:

-Select Low disk use / Low Throughput / 1.5 mil gas/s (C-Chain's setting).
-Choose to Airdrop 1 million tokens to the default ewoq address (do not use this in production).

4. Compile and Deploy Contracts
ERC20 Token Contract
Compile:

1. Open Remix IDE.
2. Create a new file named ERC20.sol.
3. Copy the ERC20.sol code into the file.
4. Ensure the compiler version is set to ^0.8.17.
5. Click "Compile ERC20.sol".
## Deploy:

In the "Deploy & Run Transactions" tab, ensure the environment is set to Injected Web3 (MetaMask).
Deploy the ERC20 contract.
Vault Contract
## Compile:

-In Remix, create a new file named Vault.sol.
-Copy the Vault.sol code into the file.
-Ensure the compiler version is set to ^0.8.17.
-Click "Compile Vault.sol".

##Deploy:

-In the "Deploy & Run Transactions" tab, ensure the environment is set to Injected Web3 (MetaMask).
-Deploy the Vault contract by providing the address of the deployed ERC20 token contract as the constructor parameter.
-By following these steps, you will have your Vault and ERC20 contracts set up and deployed on an Avalanche subnet. 
-Ensure that you have your MetaMask configured to interact with the Avalanche network for successful deployment and interactions.

Author:
Rahul Tiwary
rahult7526@gmail.com
