// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Parent {
    string internal myVar;

    function setMyVar(string memory _var) external {
        myVar = _var;
    }
}

contract Child is Parent {
    function getParentVar() external view returns (string memory) {
        return myVar;
    }
}

contract Caller {
    Child newChild = new Child();

    function getParentVarByChild(string memory _var) external {
        newChild.setMyVar(_var);
    }
}
