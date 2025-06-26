// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Clase1} from "../src/Clase1.sol";

contract Clase1Test is Test {
    Clase1 public clase1;

    function setUp() public {
        clase1 = new Clase1();
    }

    function testInitialSupplyIsZero() public view {
        uint256 supply = clase1.totalSupply();
        assertEq(supply, 0, "Supply must be 0 at the beginning");
    }

    //CREACION DE TESTS

    //1. el nombre del token debe ser Safe token - Kiben y en

    //2. el estado inicial del contrato no debe ser pausado y al hacer swith debe estar pausado y no dejar ejecutar un addMinter

    //3. Solo el propietario debe poder hacer switch

    //4. El supply del contrato inicialmente debe ser 0

    //5. Despues de minar 100 u el supply debe ser 100

    //6. Dada una direccion de minero, tratar de crear mas dinero de lo permitido

    //7.Comprobar que el símbolo del token es SAFE
}
