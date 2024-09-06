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

    modifier createETickH(string memory _eventName, uint _startTime, uint _eventDuration, uint _tktCount) {
        require(bytes(_eventName).length > 0, "Event must have a name");
        require(_startTime+_eventDuration >= block.timestamp, "Event must be in future");
        require(_tktCount > 0, "Event must have tickets");
        _;
    }

    function createEvent(string memory _eventName, uint _startTime, uint _eventDuration, uint _tktCount, uint _tktPrice, address[] _orgs) createETickH(_eventName, _startTime, _eventDuration, _tktCount) public returns(bool) {

        ETickHEvent myEvent = ETickHEvent(++eventCount, _eventName, _startTime, _eventDuration, _tktCount, _tktPrice, msg.sender, _orgs);
        return true;
    }

    function buyTicket(address _eventCreator, uint _eventId, uint _ticketCount) public returns(bool) {
        (bool success,) = ; 
        return success;
    }

}
