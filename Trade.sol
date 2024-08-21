// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Trading {
    mapping(address => uint256) public items;

    function trade(address _to, uint256 _amount) public {
        require(items[msg.sender] >= _amount, "Not enough items.");
        items[msg.sender] -= _amount;
        items[_to] += _amount;
    }

    function addItem(uint256 _amount) public {
        items[msg.sender] += _amount;
    }

    function getItems() public view returns (uint256) {
        return items[msg.sender];
    }
}
