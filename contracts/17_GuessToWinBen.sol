// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";

// Custom errors consomme moins de gas que les require + string
error UserHasAlreadyPlayed(address user);
error GameIsFinished();

contract GuessToWinBen is Ownable {
    constructor() Ownable(msg.sender) {}

    string private word;
    string private hint;
    address winner;

    mapping(address => bool) hasPlayed;
    event GameWon(address indexed _winner);

    function guess(string memory _word) external returns (bool) {
        require(!hasPlayed[msg.sender], UserHasAlreadyPlayed(msg.sender));
        require(winner == address(0), GameIsFinished());
        hasPlayed[msg.sender] = true;
        if (compareString(word, _word)) {
            winner = msg.sender;
            emit GameWon(msg.sender);
            return true;
        }
        return false;
    }

    function setWordAndHint(string calldata _word, string calldata _hint)
        external
        onlyOwner
    {
        word = _word;
        hint = _hint;
    }

    function compareString(string memory _string1, string memory _string2)
        private
        pure
        returns (bool)
    {
        return keccak256(bytes(_string1)) == keccak256(bytes(_string2));
    }

    function getHint() external view returns (string memory) {
        return hint;
    }

    function getWinner() external view returns (address) {
        return winner;
    }
}
