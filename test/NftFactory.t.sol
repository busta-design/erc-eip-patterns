// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/NftFactory.sol";
import "../src/SimpleNft.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract NftFactoryTest is Test {
    NftFactory factory;
    address owner = address(0xABCD);
    address otherUser = address(0x1234);

    function setUp() public {
        vm.prank(owner);
        factory = new NftFactory();
    }

    function testImplementationAddressSet() public view {
        assertTrue(factory.implementation() != address(0));
    }

    function testCreateNFTStoresProxy() public {
        vm.prank(owner);
        address proxyAddr = factory.createNFT();
        assertEq(factory.allNFTs(0), proxyAddr);
    }

    function testOnlyOwnerCanCreateNFT() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(otherUser);
        factory.createNFT();
    }

    function testMintFromProxy() public {
        vm.prank(owner);
        address proxyAddr = factory.createNFT();

        SimpleNft proxy = SimpleNft(proxyAddr);
        vm.prank(owner);
        proxy.safeMint(owner, 1);

        assertEq(proxy.ownerOf(1), owner);
    }
}
