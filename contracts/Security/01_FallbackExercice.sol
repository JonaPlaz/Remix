// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

contract FallbackExercice {
    mapping(address => uint256) private balances;

    event ValidDeposit(address _sender, uint256 _amount);
    event InvalidCall(address _sender);

    fallback() external payable {
        emit InvalidCall(msg.sender);
    }

    receive() external payable {
        emit ValidDeposit(msg.sender, msg.value);
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        emit ValidDeposit(msg.sender, msg.value);
    }
}
