// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

contract auction {
    address highestBidder;
    uint256 highestBid;
    mapping(address => uint256) refunds;

    function bid() public payable {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdrawRefund() public payable {
        uint256 refund = refunds[msg.sender];
        refunds[msg.sender] = 0;
        (bool succes, ) = msg.sender.call{value: refund}("");
        require(succes);
    }
}
