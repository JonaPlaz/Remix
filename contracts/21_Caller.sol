// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

import "./01_Storage.sol";

/**
 * @title Caller
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Caller {
    uint256 number;

    /**
     * @dev Store a value in an external contract
     * @param addr The address of the external contract
     * @param num The value to store in the external contract
     */
    function storeExt(address addr, uint256 num) public {
        // Haut niveau
        Storage(addr).store(num);
        // Bas niveau
        (bool success, bytes memory data) = addr.call(
            abi.encodeWithSignature("store(uint)", num)
        );
        require(success);
        abi.decode(data, (uint256));
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256) {
        return number;
    }
}
