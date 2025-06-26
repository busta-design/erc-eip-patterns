// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {Script, console} from "forge-std/Script.sol";
import {Clase1} from "../src/Clase1.sol";

contract CounterScript is Script {
    Clase1 public clase1;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        clase1 = new Clase1();

        vm.stopBroadcast();
    }
}
