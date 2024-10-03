// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract People {
    struct Person {
        string name;
        uint8 age;
    }

    Person public moi;

    function modifyPerson (string memory _name, uint8 _age) public {
        moi = Person(_name, _age);
    }
}