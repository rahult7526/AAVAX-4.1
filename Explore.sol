// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Exploration {
    mapping(address => uint256) public explorationPoints;

    function explore() public {
        // Simple exploration logic
        explorationPoints[msg.sender] += 1; // Earn exploration points
    }
    
    function getPoints() public view returns (uint256) {
        return explorationPoints[msg.sender];
    }
}
