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
    
        }

    function discussedMotion(int motionID) public {
        require (motionID >= 0);
        require (motionID <= motionCount);
        motions[motionID].discussed = true;
    }
    
    function getMotion(int motionID) public view returns (Motion memory motion){
        require (motionID >= 0);
        require (motionID <= motionCount);
        return motions[motionID];
    }
}                  