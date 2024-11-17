// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPermit2 {
    struct TokenPermissions {
        IERC20 token;
        uint256 amount;
    }

    struct PermitTransferFrom {
        TokenPermissions permitted;
        uint256 nonce;
        uint256 deadline;
    }

    struct SignatureTransferDetails {
        address to;
        uint256 requestedAmount;
    }

    function permitTransferFrom(
        PermitTransferFrom calldata permit,
        SignatureTransferDetails calldata transferDetails,
        address owner,
        bytes calldata signature
    ) external;
}

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract SignatureTransferContract {
    IPermit2 public constant PERMIT2 = IPermit2(0x000000000022D473030F116dDEE9F6B43aC78BA3);

    mapping(address => mapping(IERC20 => uint256)) public balances;
    bool private _reentrancyGuard;

    modifier nonReentrant() {
        require(!_reentrancyGuard, "Reentrancy not allowed");
        _reentrancyGuard = true;
        _;
        _reentrancyGuard = false;
    }

    function deposit(
        IERC20 token,
        uint256 amount,
        uint256 nonce,
        uint256 deadline,
        bytes calldata signature
    ) external nonReentrant {
        require(amount > 0, "Invalid amount");
        balances[msg.sender][token] += amount;
        PERMIT2.permitTransferFrom(
            IPermit2.PermitTransferFrom({
                permitted: IPermit2.TokenPermissions({ token: token, amount: amount }),
                nonce: nonce,
                deadline: deadline
            }),
            IPermit2.SignatureTransferDetails({ to: address(this), requestedAmount: amount }),
            msg.sender,
            signature
        );
    }

    function withdraw(IERC20 token, uint256 amount) external nonReentrant {
        require(balances[msg.sender][token] >= amount, "Insufficient balance");
        balances[msg.sender][token] -= amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }
}
