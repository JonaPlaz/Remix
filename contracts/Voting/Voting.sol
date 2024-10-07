// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is Ownable {
    constructor() Ownable(msg.sender) {}

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint256 votedProposalId;
    }

    struct Proposal {
        string description;
        uint256 voteCount;
    }

    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }

    uint256 private winningProposalId;

    mapping(address => bool) whitelist;

    event VoterRegistered(address voterAddress);
    event WorkflowStatusChange(
        WorkflowStatus previousStatus,
        WorkflowStatus newStatus
    );
    event ProposalRegistered(uint256 proposalId);
    event Voted(address voter, uint256 proposalId);

    function authorize() public onlyOwner {

    }

    function startProposalsSession() public onlyOwner {

    }

    function registerProposal() public {

    }

    function endProposalsSession() public onlyOwner {

    }
    
    function startVotingSession() public onlyOwner {

    }

    function endVotingSession() public onlyOwner {

    }

    function countVotes() public  onlyOwner {

    }

    function getWinner() public pure returns (Proposal memory) {
        // peut être à remettre en view après implémentation
        return Proposal({description : 'proposition de test', voteCount: 20});
    }
}
