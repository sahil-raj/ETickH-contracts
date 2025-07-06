// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EventTicket721 is ERC721Enumerable, Ownable {
    string private baseTokenURI;
    uint256 public maxTickets;
    uint256 public ticketPrice;
    uint256 public totalMinted;

    event TicketMinted(address indexed buyer, uint256 indexed tokenId);

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseTokenURI,
        uint256 _maxTickets,
        uint256 _ticketPrice,
        address _organizer
    )
        ERC721(_name, _symbol)
        Ownable(_organizer) // ✅ required for OpenZeppelin >= v5
    {
        baseTokenURI = _baseTokenURI;
        maxTickets = _maxTickets;
        ticketPrice = _ticketPrice;
    }

    function mintTicket() external payable {
        require(totalMinted < maxTickets, "All tickets sold");
        require(msg.value >= ticketPrice, "Insufficient payment");

        totalMinted++;
        uint256 tokenId = totalMinted;
        _safeMint(msg.sender, tokenId);

        emit TicketMinted(msg.sender, tokenId);
    }

    function mintMultipleTickets(uint256 _quantity) external payable {
        require(totalMinted + _quantity <= maxTickets, "Not enough tickets left");
        require(msg.value >= ticketPrice * _quantity, "Insufficient payment");

        for (uint256 i = 0; i < _quantity; i++) {
            totalMinted++;
            uint256 tokenId = totalMinted;
            _safeMint(msg.sender, tokenId);
            emit TicketMinted(msg.sender, tokenId);
        }
    }

    function setBaseURI(string memory _baseTokenURI) external onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function ticketsLeft() external view returns (uint256) {
        return maxTickets - totalMinted;
    }
}
