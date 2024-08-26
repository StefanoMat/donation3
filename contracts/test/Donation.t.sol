// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Donation.sol";

contract DoacaoTest is Test {
    Donation donation;
    address payable entidade = payable(address(0x1));

    function setUp() public {
        donation = new Donation(entidade);
    }

    function testReceberDoacao() public {
        uint inicioSaldo = entidade.balance;
        address(this).call{value: 1 ether}(address(donation));
        uint fimSaldo = entidade.balance;
        assertEq(fimSaldo, inicioSaldo + 1 ether);
        assertEq(donation.totalDonations(), 1 ether);
    }

    function testAlterarEntidade() public {
        vm.prank(address(0x1));
        vm.expectRevert("Only the owner can change the beneficiary.");
        donation.changeBeneficiary(payable(address(0x2)));
    }
}