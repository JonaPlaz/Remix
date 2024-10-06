// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank {
    mapping(address => uint256) _balances;

    function deposit(uint256 _amount) public {
        _balances[msg.sender] += _amount;
    }

    function transfer(address _recipient, uint256 _amount) public {
        require(_recipient != address(0), "It's not a valid address !");
        require(
            _balances[msg.sender] >= _amount,
            "Balance is less than amount !"
        );
        _balances[_recipient] += _amount;
        _balances[msg.sender] -= _amount;
    }

    function balanceOf(address _address) public view returns (uint256) {
        return _balances[_address];
    }
}
