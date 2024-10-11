// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract ClassRatingSystem {
    struct Student {
        string name;
        uint256 noteBiology;
        uint256 noteMath;
        uint256 noteFr;
    }

    mapping(address => string) teacher;

    Student[] studentList;

    function addStudent(Student memory _student) external {
        Student memory newStudent = _student;
        studentList.push(newStudent);
    }

    function addTeacher(address _teacherAddress, string memory _teacherSubject)
        external
    {
        teacher[_teacherAddress] = _teacherSubject;
    }

    function getNote(string memory _name, string memory _subject)
        external
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < studentList.length; i++) {
            if (
                keccak256(abi.encodePacked(_name)) ==
                keccak256(abi.encodePacked(studentList[i].name))
            ) {
                if (
                    keccak256(abi.encodePacked(_subject)) ==
                    keccak256(abi.encodePacked("Biology"))
                ) {
                    return studentList[i].noteBiology;
                }
                if (
                    keccak256(abi.encodePacked(_subject)) ==
                    keccak256(abi.encodePacked("Math"))
                ) {
                    return studentList[i].noteMath;
                }
                if (
                    keccak256(abi.encodePacked(_subject)) ==
                    keccak256(abi.encodePacked("Fr"))
                ) {
                    return studentList[i].noteFr;
                }
            }
        }
        return 0;
    }
}
