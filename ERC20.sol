// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    // Transaction fee percentage (1% fee by default)
    uint256 public feePercentage = 1;
    address public feeRecipient;

    // Event to log fee changes
    event FeePercentageChanged(uint256 newFeePercentage);
    event FeeRecipientChanged(address newFeeRecipient);

    constructor(uint256 initialSupply, address _feeRecipient) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
        feeRecipient = _feeRecipient;
    }

    // Override transfer to include a fee
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 fee = (amount * feePercentage) / 100;
        uint256 amountAfterFee = amount - fee;
        _transfer(_msgSender(), recipient, amountAfterFee);
        if (fee > 0) {
            _transfer(_msgSender(), feeRecipient, fee);
        }
        return true;
    }

    // Override transferFrom to include a fee
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        uint256 fee = (amount * feePercentage) / 100;
        uint256 amountAfterFee = amount - fee;
        _transfer(sender, recipient, amountAfterFee);
        if (fee > 0) {
            _transfer(sender, feeRecipient, fee);
        }
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount);
        return true;
    }

    // Mint new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    // Set a new fee percentage
    function setFeePercentage(uint256 newFeePercentage) public onlyOwner {
        require(newFeePercentage <= 100, "Fee percentage cannot exceed 100");
        feePercentage = newFeePercentage;
        emit FeePercentageChanged(newFeePercentage);
    }

    // Set a new fee recipient
    function setFeeRecipient(address newFeeRecipient) public onlyOwner {
        feeRecipient = newFeeRecipient;
        emit FeeRecipientChanged(newFeeRecipient);
    }
}
