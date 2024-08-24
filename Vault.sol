// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Vault is Ownable, AccessControl {
    bytes32 public constant DEPOSITOR_ROLE = keccak256("DEPOSITOR_ROLE");
    uint256 public withdrawalFeePercentage = 1; // 1% withdrawal fee
    address public feeRecipient;
    mapping(address => uint256) public tokenBalances;
    mapping(address => uint256) public rewards;

    event Deposited(address indexed token, address indexed user, uint256 amount);
    event Withdrawn(address indexed token, address indexed user, uint256 amount);
    event FeeChanged(uint256 newFeePercentage);
    event FeeRecipientChanged(address newFeeRecipient);
    event RewardDistributed(address indexed token, address indexed user, uint256 amount);

    constructor(address _feeRecipient) {
        feeRecipient = _feeRecipient;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(DEPOSITOR_ROLE, msg.sender);
    }

    modifier onlyDepositors() {
        require(hasRole(DEPOSITOR_ROLE, msg.sender), "Not authorized to deposit");
        _;
    }

    function deposit(address token, uint256 amount) external onlyDepositors {
        require(amount > 0, "Amount must be greater than 0");

        ERC20(token).transferFrom(msg.sender, address(this), amount);
        tokenBalances[token] += amount;

        // Distribute rewards (example: 0.1% of the deposit as reward)
        uint256 rewardAmount = (amount * 1) / 1000; // 0.1%
        rewards[msg.sender] += rewardAmount;

        emit Deposited(token, msg.sender, amount);
        emit RewardDistributed(token, msg.sender, rewardAmount);
    }

    function withdraw(address token, uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be greater than 0");
        require(tokenBalances[token] >= amount, "Insufficient balance in vault");

        uint256 fee = (amount * withdrawalFeePercentage) / 100;
        uint256 amountAfterFee = amount - fee;

        tokenBalances[token] -= amount;
        ERC20(token).transfer(msg.sender, amountAfterFee);
        if (fee > 0) {
            ERC20(token).transfer(feeRecipient, fee);
        }

        emit Withdrawn(token, msg.sender, amount);
    }

    function emergencyWithdraw(address token, uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be greater than 0");
        require(tokenBalances[token] >= amount, "Insufficient balance in vault");

        tokenBalances[token] -= amount;
        ERC20(token).transfer(msg.sender, amount);
    }

    function setFeePercentage(uint256 newFeePercentage) external onlyOwner {
        require(newFeePercentage <= 100, "Fee percentage cannot exceed 100");
        withdrawalFeePercentage = newFeePercentage;
        emit FeeChanged(newFeePercentage);
    }

    function setFeeRecipient(address newFeeRecipient) external onlyOwner {
        feeRecipient = newFeeRecipient;
        emit FeeRecipientChanged(newFeeRecipient);
    }

    function grantDepositorRole(address account) external onlyOwner {
        grantRole(DEPOSITOR_ROLE, account);
    }

    function revokeDepositorRole(address account) external onlyOwner {
        revokeRole(DEPOSITOR_ROLE, account);
    }

    function balanceOf(address token) external view returns (uint256) {
        return tokenBalances[token];
    }

    function rewardOf(address user) external view returns (uint256) {
        return rewards[user];
    }
}
