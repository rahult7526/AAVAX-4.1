// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "PowerUpRahul";
    string public symbol = "PWR";
    uint8 public decimals = 18;

    event PowerTransferred(address indexed from, address indexed to, uint value);
    event PowerApproved(address indexed player, address indexed spender, uint value);

    // Function for players to send Power-Ups to other players
    function transferPowerUp(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit PowerTransferred(msg.sender, recipient, amount);
        return true;
    }

    // Function for players to authorize another player to spend their Power-Ups
    function approveSpender(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit PowerApproved(msg.sender, spender, amount);
        return true;
    }

    // Function for a player to spend Power-Ups on behalf of another player
    function spendPowerUpFrom(
        address player,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[player][msg.sender] -= amount;
        balanceOf[player] -= amount;
        balanceOf[recipient] += amount;
        emit PowerTransferred(player, recipient, amount);
        return true;
    }

    // Function for players to create new Power-Ups
    function mintPowerUp(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit PowerTransferred(address(0), msg.sender, amount);
    }

    // Function for players to destroy their Power-Ups
    function burnPowerUp(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit PowerTransferred(msg.sender, address(0), amount);
    }
}
