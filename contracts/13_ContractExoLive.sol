// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

// contract Ownable {
//     address owner;

//     constructor() {
//         owner = msg.sender;
//     }

//     modifier onlyOwner() {
//         require(msg.sender == owner, "Not the owner");
//         _;
//     }
// }

import "@openzeppelin/contracts/access/Ownable.sol";

contract ContractExoLive4 is Ownable {
    constructor() Ownable(msg.sender) {}

    uint256 public myNumber;

    function setNumber(uint256 _myNumber) external onlyOwner {
        myNumber = _myNumber;
    }
}
