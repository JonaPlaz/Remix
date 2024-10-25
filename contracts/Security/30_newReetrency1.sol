// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

// You can store ETH in this contract and redeem them.
contract Vault {
    mapping(address => uint256) public balances;
    bool guard;

    /// @dev Store ETH in the contract.
    function store() public payable {
        balances[msg.sender] += msg.value;
    }

    /// @dev Redeem your ETH.
    function redeemWithGuard() public {
        require(guard == false, "Be careful to attacks, guard has to be false");
        guard = true;
        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Transfer failed");
        balances[msg.sender] = 0;
    }

    /// @dev Redeem your ETH.
    function redeemWithUpdateBalance() public {
        require(balances[msg.sender] > 0, "Not enough funds");
        uint256 tempBalance = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: tempBalance}("");
        require(success, "Transfer failed");
    }
}
