// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract ContractExoLive2 {
    function deposit() external payable {
        // Ici on fait quelque chose avec le msg.value
    }

    function withdrax(address _to) external {
        payable(_to).transfer(address(this).balance);
    }

    receive() external payable { }

    fallback() external payable { }
}
