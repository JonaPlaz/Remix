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
        whitelist[_address].isRegistered = true;
        emit VoterRegistered(_address);
    }

    function workFlowStatusChange(WorkflowStatus _newStatus) private {
        emit WorkflowStatusChange(currentStatus, _newStatus);
        currentStatus = _newStatus;
    }

    function startProposalsRegistration() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.RegisteringVoters,
            "Cannot start proposal registration at this stage"
        );
        workFlowStatusChange(WorkflowStatus.ProposalsRegistrationStarted);
    }

    modifier isRegisteredVoter(address _address) {
        require(whitelist[_address].isRegistered, "Voter is not registered");
        _;
    }

    function registerProposal(address _address, string memory _description)
        public
        isRegisteredVoter(_address)
    {
        require(
            currentStatus == WorkflowStatus.ProposalsRegistrationStarted,
            "Cannot register proposal"
        );

        proposalList.push(Proposal({description: _description, voteCount: 0}));

        emit ProposalRegistered(proposalList.length);
    }

    function endProposalsRegistration() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.ProposalsRegistrationStarted,
            "Cannot end proposal registration at this stage"
        );
        workFlowStatusChange(WorkflowStatus.ProposalsRegistrationEnded);
    }

    function startVotingSession() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.ProposalsRegistrationEnded,
            "Cannot start voting session at this stage"
        );
        workFlowStatusChange(WorkflowStatus.VotingSessionStarted);
    }

    function voteForProposal(address _address, uint256 _proposalId)
        public
        isRegisteredVoter(_address)
    {
        require(
            currentStatus == WorkflowStatus.VotingSessionStarted,
            "Cannot start counting votes"
        );
        require(!whitelist[_address].hasVoted, "Voter has already voted");
        require(_proposalId <= proposalList.length, "Invalid proposal id");

        whitelist[_address].hasVoted = true;
        whitelist[_address].votedProposalId = _proposalId;
        proposalList[_proposalId - 1].voteCount++;
        emit Voted(_address, _proposalId);
    }

    function endVotingSession() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.VotingSessionStarted,
            "Cannot end voting session at this stage"
        );
        workFlowStatusChange(WorkflowStatus.VotingSessionEnded);
    }

    function countVotes() public onlyOwner {
        require(
            currentStatus == WorkflowStatus.VotingSessionEnded,
            "Cannot start counting votes"
        );

        uint256 maxVotes = 0;
        for (uint256 i = 0; i < proposalList.length; i++) {
            if (proposalList[i].voteCount > maxVotes) {
                maxVotes = proposalList[i].voteCount;
                winningProposalId = i + 1;
            }
        }

        workFlowStatusChange(WorkflowStatus.VotesTallied);
    }

    function getWinner() public view returns (Proposal memory) {
        return proposalList[winningProposalId - 1];
    }
}
