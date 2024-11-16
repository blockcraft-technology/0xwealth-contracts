// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract SignatureTransferContract {
    address public owner;

    event TokensTransferred(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function signatureTransfer(
        address from,
        address token,
        uint256 amount
    ) external {
        require(amount > 0, "Amount must be greater than zero");

        bool success = IERC20(token).transfer(from, amount);
        require(success, "Token transfer failed");

        emit TokensTransferred(from, address(this), amount);
    }
}
