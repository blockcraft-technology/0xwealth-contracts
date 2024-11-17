// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract USDCDistributor {
    address public owner;
    address public constant USDC_ADDRESS = 0x79A02482A880bCE3F13e09Da970dC34db4CD24d1;
    IERC20 public constant USDC = IERC20(USDC_ADDRESS);

    event Payout(address indexed destination, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function payout(address destination, uint256 amount) external onlyOwner {
        require(destination != address(0), "Invalid destination address");
        require(USDC.balanceOf(address(this)) >= amount, "Insufficient balance");
        require(USDC.transfer(destination, amount), "Transfer failed");

        emit Payout(destination, amount);
    }
}
