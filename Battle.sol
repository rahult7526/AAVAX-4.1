// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Battle {
    struct Player {
        uint256 health;
        uint256 attackPower;
    }
    
    mapping(address => Player) public players;
    
    function registerPlayer(uint256 _health, uint256 _attackPower) public {
        players[msg.sender] = Player(_health, _attackPower);
    }
    
    function battle(address _opponent) public {
        require(players[msg.sender].health > 0, "You have no health left.");
        require(players[_opponent].health > 0, "Opponent has no health left.");
        
        // Simple battle logic
        if (players[msg.sender].attackPower > players[_opponent].attackPower) {
            players[_opponent].health = 0; // Opponent loses
        } else {
            players[msg.sender].health = 0; // You lose
        }
    }
}
