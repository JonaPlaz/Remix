// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract ContractExoLive3 {
    mapping(address => uint256) balances;

    event Deposit(address indexed user, uint256);
    event Withdraw(address indexed user, uint256);

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "You have no funds");
        balances[msg.sender] -= _amount;
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Failed");
        emit Withdraw(msg.sender, _amount);
    }

    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }
}
