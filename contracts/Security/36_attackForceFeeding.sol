// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

import "./36_forceFeeding.sol";

contract attackForceFeeding {
    Bank public bank;

    constructor(Bank _bank) {
        bank = _bank;
    }

    receive() external payable {}

    function attackBank() external {
        //    selfDestruct(payable(address(bank)));
    }
}
