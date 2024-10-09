// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract People {
    struct Person {
        string name;
        uint8 age;
    }

    Person public moi;

    Person[] public persons;

    function modifyPerson(string memory _name, uint8 _age) public {
        moi = Person(_name, _age);
    }

    function add(string memory _name, uint8 _age) public {
        persons.push(Person(_name, _age));
    }

    function remove() public {
        persons.pop();
    }

    function retrieve() public view returns (Person[] memory) {
        return persons;
    }
}
