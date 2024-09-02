// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract TokenDonation is ERC1155, Ownable {

  using Strings for uint265;

  mapping(uint256 => string) private _eventURIs;

  event EventCreated(uint256 indexed eventId, string uri);
  event DonationReceived(address indexed contributor, uint256 indexed eventId, uint256 amount);

  constructor() ERC1155("") {}

  function createEvent(uint256 eventId, string memory eventURI) public onlyOwner {
    _eventURIs[eventId] = eventURI;
    emit EventCreated(eventId, eventURI);
  }

  function uri(uint256 eventId) public view override returns (string memory) {
    return _eventURIs[eventId];
  }

  function mintDonate(uint256 eventId, uint256 amount) public {
    require(bytes(_eventURIs[eventId]).length > 0, "Event does not exist");
    _mint(msg.sender, eventId, amout, "");
    emit DonationReceived(msg.sender, eventId, amount);
  }

  function batchMintDonate(address[] memory contributors, uint256[] memory eventIds, uint256[] memory amounts) public onlyOwner {
    require(contributors.length == eventIds.length && eventIds.length == amounts.length, "Array lengths do not match");

    for (uint256 i = 0; i < contributors.length; i++) {
      require(bytes(_eventURIs[eventIds[i]]).length > 0, "Event does not exist");
      _mint(contributors[i], eventIds[i], amounts[i], "");
      emit DonationReceived(contributors[i], eventIds[i], amounts[i]);
    }
  }

  function withdraw() public onlyOwner {
    payable(owner()).transfer(address(this).balance);
  }

  receive() external payable {
    emit DonationReceived(msg.sender, 0, msg.value);
  }
}