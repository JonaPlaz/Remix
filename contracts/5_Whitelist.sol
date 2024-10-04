// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Whitelist {

    mapping (address => bool) whitelist;

    event Authorized(address _address);
}