//SPDX-License-Identifier: MIT
//contracts/ETickH.sol
pragma solidity ^0.8.4;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

///@title
///@author github.com/sahil-raj
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
        address payable creator;
        address[] organizers;
    }

    mapping(address => ETickHEvent[]) public eventMapping;
    mapping(uint => ETickHEvent) internal idToEventMap;

    modifier createETickH(string memory _eventName, uint _startTime, uint _eventDuration, uint _tktCount) {
        require(bytes(_eventName).length > 0, "Event must have a name");
        require(_startTime+_eventDuration >= block.timestamp, "Event must be in future");
        require(_tktCount > 0, "Event must have tickets");
        _;
    }

    modifier buyTicketMod(address _eventCreator, uint _eventId, uint _ticketCount) {
        //check if the creator by user and creator by eventId matches
        require(idToEventMap[_eventId].creator == _eventCreator, "creator missmatch");
        //check if tickets are available
        require(idToEventMap[_eventId].ticket_count >= _ticketCount);
        //msg.value must be equal or greater than req.
        require(msg.value >= idToEventMap[_eventId].ticket_price*_ticketCount, "insuffcient funds");
        _;
    }

    function createEvent(string memory _eventName, uint _startTime, uint _eventDuration, uint _tktCount, uint _tktPrice, address[] memory _orgs) createETickH(_eventName, _startTime, _eventDuration, _tktCount) public returns(bool) {

        ETickHEvent memory myEvent = ETickHEvent(++eventCount, _eventName, _startTime, _eventDuration, _tktCount, _tktPrice, payable(msg.sender), _orgs);

        eventMapping[msg.sender].push(myEvent);
        idToEventMap[eventCount] = myEvent;

        return true;
    }

    function buyTicket(address _eventCreator, uint _eventId, uint _ticketCount) buyTicketMod(_eventCreator, _eventId, _ticketCount) public payable returns(bool) {

        bool success = false;

        // for (uint i=0; i< eventMapping[_eventCreator].length;) {
        //     if (eventMapping[_eventCreator][i].event_id == _eventId) {
        //         success = eventMapping[_eventCreator][i].creator.send(msg.value);
        //         break;
        //     }
        //     unchecked {
        //         ++i;
        //     }
        // }

        success = idToEventMap[_eventId].creator.send(msg.value);

        idToEventMap[_eventId].ticket_count -= _ticketCount;

        return success;
    }

}