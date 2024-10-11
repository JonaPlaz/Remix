// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Bytes {
    bytes1 public b1 = 0xb5; // 1 octet
    bytes2 public b2 = 0x1234; // 2 octets

    bytes public data; // bytes dynamique (comme pour les tableaux) + plus couteux en gas que les bytes fixes

    string public myString;

    function setMyString(string memory _myString) external {
        myString = _myString;
    }

    function stringLength() external view returns (uint256) {
        bytes memory convertMyString = bytes(myString);
        return convertMyString.length;
    }
}
