// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import { Test, console2, Vm } from "forge-std/Test.sol";
import { FactoryNFTContract } from "../../src/FactoryNFTContract.sol";

contract FactoryNFTContractTest is Test {
    FactoryNFTContract factory;

    address OWNER = makeAddr("owner");
    address ZERO = address(0);

    string name = "MY NFT COLLECTION";
    string symbol = "MYCOL";
    string baseURI = "ipfs://";
    uint256 maxSupply = 10;
    uint256 royaltyPercentage = 10;

    function setUp() public {
        factory = new FactoryNFTContract(OWNER);
    }

    function testRevertOnInvalidInitialOwner() public {
        vm.expectRevert(FactoryNFTContract.FactoryNFTContract__InvalidInitialOwner.selector);
        new FactoryNFTContract(ZERO);
    }

    function testSuccessfulCreateCollection() public {
        vm.prank(OWNER);
        factory.createCollection(name, symbol, baseURI, maxSupply, OWNER, royaltyPercentage);
        assertEq(factory.getCollections().length, 1);
    }

    function testGetCollections() public {
        vm.prank(OWNER);
        factory.createCollection(name, symbol, baseURI, maxSupply, OWNER, royaltyPercentage);
        address expectedAddress = factory.getCollections()[0];
        address[] memory collections = factory.getCollections();
        assertEq(collections.length, 1, "Should have exactly one collection");
        assertEq(expectedAddress, factory.getCollections()[0]);
    }
}
