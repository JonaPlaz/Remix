// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Crowdsale is ERC20 {
    string private _name;
    string private _symbol;

    constructor() ERC20("CoursAlyra", "Cal") {}
}
