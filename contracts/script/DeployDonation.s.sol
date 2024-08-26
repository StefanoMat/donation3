// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Donation.sol";

contract DeployDonation is Script {
    function run() external {
        vm.startBroadcast();

        address payable entidadeBeneficiaria = payable(
            0xa18a02BF43366a2410C3D1d34F435C00D3120456
        ); // Substitua pelo endereço real da entidade beneficiária

        Donation donation = new Donation(entidadeBeneficiaria);

        payable(address(donation)).transfer(0.05 ether);

        vm.stopBroadcast();
    }
}
