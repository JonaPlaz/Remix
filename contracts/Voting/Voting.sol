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
    WorkflowStatus public currentStatus;

    mapping(address => Voter) whitelist;
    mapping(address => uint256) public voterProposalIds;
    Proposal[] public proposalList;

    event VoterRegistered(address voterAddress);
    event WorkflowStatusChange(
        WorkflowStatus previousStatus,
        WorkflowStatus newStatus
    );
    event ProposalRegistered(uint256 proposalId);
    event Voted(address voter, uint256 proposalId);

    function authorize(address _address) public onlyOwner {
        require(
            currentStatus == WorkflowStatus.RegisteringVoters,
            "Voter registration is not allowed at this stage"
        );
        require(!whitelist[_address].isRegistered, "already in the whitelist");
        whitelist[_address].isRegistered;
        emit VoterRegistered(_address);
    }

    function startProposalsRegistration() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.RegisteringVoters,
            "Cannot start proposal registration at this stage"
        );
        WorkflowStatus newStatus = WorkflowStatus.ProposalsRegistrationStarted;
        emit WorkflowStatusChange(currentStatus, newStatus);
        currentStatus = newStatus;
    }

    function registerProposal(address _address, string memory _description)
        public
    {
        require(
            currentStatus == WorkflowStatus.ProposalsRegistrationStarted,
            "Cannot register proposal"
        );
        require(whitelist[_address].isRegistered, "Voter is not registered");
        Proposal memory newProposal = Proposal({
            description: _description,
            voteCount: 0
        });
        proposalList.push(newProposal);

        uint256 proposalId = proposalList.length;

        voterProposalIds[_address] = proposalId;

        emit ProposalRegistered(proposalId);
    }

    function endProposalsRegistration() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.ProposalsRegistrationStarted,
            "Cannot end proposal registration at this stage"
        );
        WorkflowStatus newStatus = WorkflowStatus.ProposalsRegistrationEnded;
        emit WorkflowStatusChange(currentStatus, newStatus);
        currentStatus = newStatus;
    }

    function startVotingSession() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.ProposalsRegistrationEnded,
            "Cannot start voting session at this stage"
        );
        WorkflowStatus newStatus = WorkflowStatus.VotingSessionStarted;
        emit WorkflowStatusChange(currentStatus, newStatus);
        currentStatus = newStatus;
    }

    function endVotingSession() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.VotingSessionStarted,
            "Cannot end voting session at this stage"
        );
        WorkflowStatus newStatus = WorkflowStatus.VotingSessionEnded;
        emit WorkflowStatusChange(currentStatus, newStatus);
        currentStatus = newStatus;
    }

    function voteForProposal(address _address, uint256 _proposalId) public {
        require(
            currentStatus == WorkflowStatus.VotingSessionStarted,
            "Cannot start counting votes"
        );
        require(whitelist[_address].isRegistered, "Voter is not registered");
        require(!whitelist[_address].hasVoted, "Voter has already voted");
        require(_proposalId < proposalList.length, "Invalid proposal id");

        emit Voted(_address, _proposalId);
    }

    function countVotes() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.VotingSessionEnded,
            "Cannot start counting votes"
        );
        WorkflowStatus newStatus = WorkflowStatus.VotesTallied;
        emit WorkflowStatusChange(currentStatus, newStatus);
        currentStatus = newStatus;
        winningProposalId = 10; // en attente du compte
    }

    function getWinner() public pure returns (Proposal memory) {
        // peut être à remettre en view après implémentation
        return Proposal({description: "proposition de test", voteCount: 20});
    }
}
