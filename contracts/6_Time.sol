// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Time {
    function getTime() public view returns (uint) {
        return block.timestamp;
    }
}