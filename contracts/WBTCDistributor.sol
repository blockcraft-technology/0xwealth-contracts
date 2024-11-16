// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract WBTCDistributor {
    address public owner;
    address public constant WBTC_ADDRESS = 0x03C7054BCB39f7b2e5B2c7AcB37583e32D70Cfa3;
    IERC20 public constant WBTC = IERC20(WBTC_ADDRESS);

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
        require(WBTC.balanceOf(address(this)) >= amount, "Insufficient balance");
        require(WBTC.transfer(destination, amount), "Transfer failed");

        emit Payout(destination, amount);
    }
}
