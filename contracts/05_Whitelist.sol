// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Whitelist {
    mapping(address => bool) whitelist;

    event Authorized(address _address);

    // event EthReceived(address _addr, uint value);

    constructor() {
        whitelist[msg.sender] = true;
    }

    modifier check() {
        require(whitelist[msg.sender], "You are not authorized!");
        _;
    }

    function authorize(address _address) public check {
        whitelist[_address] = true;
        emit Authorized(_address);
    }

    // receive() external payable {
    //     emit EthReceived(msg.sender, msg.value);
    //  }

    // fallback() external payable {
    //     emit EthReceived(msg.sender, msg.value);
    //  }
}
