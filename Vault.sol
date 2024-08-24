// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event PowerTransferred(address indexed from, address indexed to, uint value);
    event PowerApproved(address indexed owner, address indexed spender, uint value);
}

contract GameVault {
    IERC20 public immutable powerUpToken;

    uint public totalShares;
    mapping(address => uint) public sharesOwned;

    uint public withdrawalFeeBasisPoints = 50; // 0.5% fee

    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Invalid token address");
        powerUpToken = IERC20(_tokenAddress);
    }

    // Internal function to credit shares to a player (Minting)
    function _creditShares(address _player, uint _shares) internal {
        totalShares += _shares;  // Mint new shares
        sharesOwned[_player] += _shares;
    }

    // Internal function to debit shares from a player (Burning)
    function _debitShares(address _player, uint _shares) internal {
        require(sharesOwned[_player] >= _shares, "Insufficient shares");
        totalShares -= _shares;  // Burn shares
        sharesOwned[_player] -= _shares;
    }

    // External function for players to deposit Power-Ups into the vault and receive shares
    function depositPowerUp(uint _amount) external {
        require(_amount > 0, "Deposit amount must be greater than zero");

        uint sharesToMint;
        uint currentBalance = powerUpToken.balanceOf(address(this));

        if (totalShares == 0) {
            sharesToMint = _amount;
        } else {
            sharesToMint = (_amount * totalShares) / currentBalance;
        }

        _creditShares(msg.sender, sharesToMint);  // Minting shares on deposit
        require(powerUpToken.transferFrom(msg.sender, address(this), _amount), "Transfer failed");

        emit PowerUpDeposited(msg.sender, _amount, sharesToMint);
    }

    // External function for players to withdraw Power-Ups by burning their shares
    function withdrawPowerUp(uint _shares) external {
        require(_shares > 0, "Withdraw shares must be greater than zero");
        require(sharesOwned[msg.sender] >= _shares, "Insufficient shares");

        uint currentBalance = powerUpToken.balanceOf(address(this));
        uint amountToWithdraw = (_shares * currentBalance) / totalShares;

        // Apply withdrawal fee
        uint fee = (amountToWithdraw * withdrawalFeeBasisPoints) / 10000;
        uint amountAfterFee = amountToWithdraw - fee;

        _debitShares(msg.sender, _shares);  // Burning shares on withdrawal
        require(powerUpToken.transfer(msg.sender, amountAfterFee), "Transfer failed");

        emit PowerUpWithdrawn(msg.sender, amountAfterFee, _shares, fee);
    }

    // Function to calculate the current share price in Power-Ups
    function getSharePrice() external view returns (uint) {
        if (totalShares == 0) {
            return 1e18; // Initial share price
        }
        return (powerUpToken.balanceOf(address(this)) * 1e18) / totalShares;
    }

    // Function to estimate the amount of Power-Ups a player can withdraw for a given number of shares
    function estimateWithdrawal(uint _shares) external view returns (uint) {
        if (_shares > totalShares) {
            return 0;
        }
        return (_shares * powerUpToken.balanceOf(address(this))) / totalShares;
    }

    // External function to retrieve any non-primary Power-Up tokens from the vault
    function retrieveNonPrimaryToken(address _otherToken) external {
        require(_otherToken != address(powerUpToken), "Cannot retrieve primary Power-Up token");
        IERC20 otherToken = IERC20(_otherToken);
        uint balance = otherToken.balanceOf(address(this));
        require(otherToken.transfer(msg.sender, balance), "Token retrieval failed");
    }

    // Events with game-themed names
    event PowerUpDeposited(address indexed depositor, uint amount, uint sharesMinted);
    event PowerUpWithdrawn(address indexed withdrawer, uint amount, uint sharesBurned, uint fee);
}
