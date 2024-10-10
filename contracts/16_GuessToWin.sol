// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";

contract GuessToWin is Ownable {
    constructor() Ownable(msg.sender) {}

    string public hint;
    string public word;
    mapping(address => bool) hasPlayed;
    address public winner;

    function updateWordAndHint(string memory _word, string memory _hint)
        external
        onlyOwner
    {
        hint = _hint;
        word = _word;
    }

    function getHint() external view returns (string memory) {
        return hint;
    }

    function _toLower(string memory str) internal pure returns (string memory) {
        bytes memory bStr = bytes(str);
        bytes memory bLower = new bytes(bStr.length);
        for (uint256 i = 0; i < bStr.length; i++) {
            if ((bStr[i] >= 0x41) && (bStr[i] <= 0x5A)) {
                bLower[i] = bytes1(uint8(bStr[i]) + 32);
            } else {
                bLower[i] = bStr[i];
            }
        }
        return string(bLower);
    }

    function submitWord(address _player, string memory _word)
        external
        returns (bool)
    {
        require(_player != address(0), "Player Cannot be address 0");
        require(hasPlayed[_player] == false, "You have already played !");
        hasPlayed[_player] = true;
        if (
            keccak256(abi.encodePacked(_toLower(word))) ==
            keccak256(abi.encodePacked(_toLower(_word)))
        ) {
            winner = _player;
            return true;
        }

        return false;
    }

    function getWinner() external view returns (address) {
        require(winner != address(0), "The winner cannot be address 0");
        return winner;
    }
}
