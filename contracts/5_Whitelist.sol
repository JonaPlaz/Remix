// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Whitelist {

    mapping (address => bool) whitelist;

    event Authorized(address _address);
    // event EthReceived(address _addr, uint value);

    function authorize(address _address) public {
        require(check(), "You are not authorized !");
        whitelist[_address] = true;
        emit Authorized(_address);
    }

    // receive() external payable {
    //     emit EthReceived(msg.sender, msg.value);
    //  }

    // fallback() external payable {
    //     emit EthReceived(msg.sender, msg.value);
    //  }

    function check() private view returns (bool) {
       return whitelist[msg.sender];
    }
}