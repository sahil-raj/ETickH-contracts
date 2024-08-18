//SPDX-License-Identifier: MIT
//contracts/ETickH.sol

pragma solidity ^0.8.4;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ETickH is Ownable {
    constructor(address _initOwner) Ownable(_initOwner) {}

    uint eventCount = 0;

    struct ETickHEvent {
        uint event_id;
        string event_name;
        uint start_timestamp;
        uint event_duration;
        uint ticket_count;
        uint ticket_price;
        address creator;
        address[] organizers;
    }

    mapping(address => ETickHEvent[]) internal eventMapping;

    function createEvent(string memory _eventName, uint _startTime, uint _eventDuration, uint _tktCount, _tktPrice, address[] _orgs) public returns(bool) {
        

        return true;
    }
    


}
