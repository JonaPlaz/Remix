// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ContractExoLive5 is Ownable {
    constructor() Ownable(msg.sender) {}

    // struct Transaction {
    //     uint256 amount;
    //     uint256 timestamp;
    // }

    // mapping(address => Transaction[]) transactionList;
    // mapping(address => uint256) balance;

    // function deposit(uint256 _amount) external payable onlyOwner {
    //     balance[msg.sender] += _amount;
    //     Transaction memory newTransaction = Transaction({
    //         amount: _amount,
    //         timestamp: block.timestamp
    //     });

    //     transactionList[msg.sender].push(newTransaction);
    // }

    // function withdraw(uint256 _amount) external onlyOwner {
    //     require(balance[msg.sender] >= _amount, "You have no funds");
    //     require(canWithdraw(msg.sender));
    //     balance[msg.sender] -= _amount;
    //     (bool sent, ) = payable(msg.sender).call{value: _amount}("");
    //     require(sent, "Failed");
    // }

    // function canWithdraw(address _user) public view returns (bool) {
    //     require(transactionList[_user].length == 0, "There is no transaction");

    //     uint256 firstTransactionTime = transactionList[_user][0].timestamp;

    //     return block.timestamp >= firstTransactionTime + 90 days;
    // }

    // function getTransactions() public view returns (Transaction[] memory) {
    //     return transactionList[msg.sender];
    // }

    mapping(uint256 => uint256) deposits;
    uint256 depositNumber;
    uint256 time;

    function deposit() external payable onlyOwner {
        require(msg.value > 0, "Not enough funds provided");
        deposits[depositNumber] = msg.value;
        depositNumber++;
        if (time == 0) {
            time = block.timestamp + 90 days;
        }
    }

    function withdraw() external onlyOwner {
        require(
            block.timestamp >= time,
            "Wait 3 month after the first deposit to wihtdraw"
        );
        require(address(this).balance > 0, "No Ethers on teh contract");
        (bool sent, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(sent, "An error occured");
    }
}
