// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract TDCdao {

    int motionCount = -1;
    mapping (address => string) private brothers;
    mapping (int => Motion) private motions;

    struct Motion {
        string creator;
        address creatorAddress;
        string motionBody;
        bool passed;
        bool discussed;
        bool openToVote;
        Vote[] votes;
    }

    struct Vote {
        string voter;
        address voterAddress;
        bool pass;
    }

    function proposeMotion(string memory _motionBody) public {
        motionCount++;

        string storage _name = brothers[msg.sender];
        Motion storage newMotion = motions[motionCount];
        
        newMotion.creator = _name;
        newMotion.creatorAddress = msg.sender;
        newMotion.motionBody = _motionBody;
        newMotion.passed = false;
        newMotion.discussed = false;
        newMotion.openToVote = false;
        }

    function discussedMotion(int motionID) public {
        require (motionID >= 0);
        require (motionID <= motionCount);
        motions[motionID].discussed = true;
    }

    function motionToVote(int motionID) public {
        require (motionID >= 0);
        require (motionID <= motionCount);
        require (motions[motionID].discussed == true);
        motions[motionID].openToVote = true;
    }

    function castVote(int motionID, bool vote) public {
        require (motionID >= 0);
        require (motionID <= motionCount);

        string storage _voter = brothers[msg.sender];
        Vote memory newVote = Vote(_voter, msg.sender, vote);
        motions[motionID].votes.push(newVote);
    }

    function endVoting(int motionID) public {
        require (motionID >= 0);
        require (motionID <= motionCount);

        Motion storage motion = motions[motionID];
        if (motion.openToVote) {
            motion.passed = _getVoteResult(motion.votes);
            motion.openToVote = false;
        }
    }

    function _getVoteResult(Vote[] storage votes) private view returns (bool result) {
        int passVotes = 0;
        int rejectVotes = 0;

        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].pass) {
                passVotes++;
            } else {
                rejectVotes++;
            }
        }
        return passVotes > rejectVotes;
    }
    
    function getMotion(int motionID) public view returns (Motion memory motion){
        require (motionID >= 0);
        require (motionID <= motionCount);
        return motions[motionID];
    }

    function getNumMotions() public view returns (int num) {
        return motionCount;
    }
}


// TODO making motions to be their own contract
// using a struct was limiting, was not able to limit votes on a motion to one per address.
contract MotionContract {
    address creatorAddress;
    string motionBody;
    bool passed;
    bool discussed;
    bool openToVote;
    Vote[] votes;

    struct Vote {
        string voter;
        address voterAddress;
        bool pass;
    }
}