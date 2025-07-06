// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./EventTicket721.sol"; // Import your EventTicket contract

contract EventFactory {
    // Store addresses of all event contracts
    address[] public allEventContracts;

    // Mapping organizer => their deployed event contracts
    mapping(address => address[]) public organizerToEvents;

    event EventCreated(
        address indexed organizer,
        address indexed eventContract,
        string eventName,
        uint256 timestamp
    );

    function createEvent(
        string memory _name,
        string memory _symbol,
        string memory _baseTokenURI,
        uint256 _maxTickets,
        uint256 _ticketPrice
    ) external returns (address) {
        // Deploy a new EventTicket721
        EventTicket721 eventContract = new EventTicket721(
            _name,
            _symbol,
            _baseTokenURI,
            _maxTickets,
            _ticketPrice,
            msg.sender // organizer is the owner
        );

        address eventAddress = address(eventContract);

        // Track it
        allEventContracts.push(eventAddress);
        organizerToEvents[msg.sender].push(eventAddress);

        // Emit for frontend indexing
        emit EventCreated(msg.sender, eventAddress, _name, block.timestamp);

        return eventAddress;
    }

    // View functions
    function getAllEvents() external view returns (address[] memory) {
        return allEventContracts;
    }

    function getEventsByOrganizer(address organizer) external view returns (address[] memory) {
        return organizerToEvents[organizer];
    }
}
