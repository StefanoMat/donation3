// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Donation {
    address public owner;
    address payable public beneficiaryEntity;
    uint public totalDonations;

    constructor(address payable _beneficiaryEntity) {
        owner = msg.sender;
        beneficiaryEntity = _beneficiaryEntity;
    }

    receive() external payable {
        require(msg.value > 0, "Donation must be greater than 0.");
        totalDonations += msg.value;
        beneficiaryEntity.transfer(msg.value); // Transferring directly to the beneficiary entity
    }

    function changeBeneficiary(address payable _newBeneficiary) public {
        require(msg.sender == owner, "Only the owner can change the beneficiary.");
        beneficiaryEntity = _newBeneficiary;
    }

    function getBalance() public view returns (uint) {
        return beneficiaryEntity.balance;
    }
}
