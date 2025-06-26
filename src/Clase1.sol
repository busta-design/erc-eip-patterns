// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Clase1 is ERC20, Ownable {
    bool public paused;

    event Paused(bool pauseAction);

    mapping(address => uint256) public minters;

    constructor() ERC20("Safe Token", "SAFE") Ownable(msg.sender) {
        // _mint(msg.sender, 100e18);
    }

    modifier onlyMinter(uint256 _amountToMint) {
        require(minters[msg.sender] > _amountToMint, "Can not mint more");
        _;
    }

    modifier onlyUnPaused() {
        require(!paused, "Contract paused");
        _;
    }

    function switchPause() public onlyOwner {
        paused = !paused;
        emit Paused(paused);
    }

    function addMinter(
        address _minter,
        uint256 _allowanceToMint
    ) public onlyOwner onlyUnPaused {
        minters[_minter] = _allowanceToMint;
    }

    function mint(
        address _to,
        uint256 _amountToMint
    ) public onlyUnPaused onlyMinter(_amountToMint) {
        _mint(_to, _amountToMint);
    }
}
