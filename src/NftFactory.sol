// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.30;
import {SimpleNft} from "./SimpleNft.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract NftFactory is Ownable {
    address public implementation;
    address[] public allNFTs;

    event NFTCreated(address indexed proxyAddress);

    constructor() Ownable(msg.sender) {
        implementation = address(new SimpleNft(msg.sender));
    }

    function createNFT() external onlyOwner returns (address) {
        ERC1967Proxy proxy = new ERC1967Proxy(
            implementation,
            abi.encodeWithSelector(
                SimpleNft(implementation).safeMint.selector,
                address(this)
            )
        );

        allNFTs.push(address(proxy));
        emit NFTCreated(address(proxy));
        return address(proxy);
    }

    function getAllNFTs() external view returns (address[] memory) {
        return allNFTs;
    }
}
