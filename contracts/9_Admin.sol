// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Admin is Ownable {
    mapping(address => bool) whitelist;
    mapping(address => bool) blacklist;

    event Whitelisted(address _address);
    event Blacklisted(address _address);

    constructor() Ownable(msg.sender) {}

    modifier checkOwner() {
        require(owner() == msg.sender, "Caller is not the owner");
        _;
    }

    function authorize(address _address) public checkOwner {
        require(!blacklist[_address], "already blacklist");
        require(!whitelist[_address], "already whitelist");
        whitelist[_address] = true;
        emit Whitelisted(_address);
    }

    // test avec onlyOwner natif de Ownable, pas besoin de modifier
    function unauthorize(address _address) public onlyOwner {
        require(!blacklist[_address], "already blacklist");
        require(!whitelist[_address], "already whitelist");
        blacklist[_address] = true;
        emit Blacklisted(_address);
    }

    function isWhitelisted(address _address) public view returns (bool) {
        return whitelist[_address];
    }

    function isBlacklisted(address _address) public view returns (bool) {
        return blacklist[_address];
    }
}
