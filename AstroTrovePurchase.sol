// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AstroTrovePurchase {
    address public immutable DEPOSIT_ADDRESS;

    event Purchase(
        address indexed from,
        uint256 amount
    );
    
    constructor(address depositAddress) {
        require(depositAddress != address(0), "Invalid deposit address");
        DEPOSIT_ADDRESS = depositAddress;
    }
    
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        
        (bool success,) = DEPOSIT_ADDRESS.call{value: msg.value}("");
        require(success, "Transfer failed");
        
        emit Purchase(msg.sender, msg.value);
    }
    
    receive() external payable {
        revert("Please use deposit function");
    }

}