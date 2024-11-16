// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract SignatureTransferContract {
    address public owner;

    event TokensTransferred(address indexed from, address indexed to, uint256 amount);

    struct PermitTransfer {
        address token;
        uint256 amount;
    }

    struct TransferDetails {
        address to;
        uint256 requestedAmount;
    }

    function signatureTransfer(
        PermitTransfer calldata permitTransfer,
        TransferDetails calldata transferDetails,
        bytes calldata signature
    ) external {
        require(
            IERC20(permitTransfer.token).transfer(transferDetails.to, transferDetails.requestedAmount),
            "Transfer failed"
        );

        emit TokensTransferred(msg.sender, transferDetails.to, transferDetails.requestedAmount);
    }

}
