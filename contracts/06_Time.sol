// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

contract Time {
    function getTime() public view returns (uint256) {
        return block.timestamp;
    }
}
