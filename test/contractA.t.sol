// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {A} from "../src/contractA.sol";
import {B} from "../src/contractB.sol";

contract contractATest is Test {
    A  a;
    B  b;

    function setUp() public{
        a = new A();
        b = new B();

        vm.deal(address(a), 0.05 ether);
    }


    function testSetVarsDelegateCall() public{
        // Initial state
       assertEq(a.num(), 0);
       assertEq(b.num(), 0);

        console.log(a.getVars());

        a.setVarsDelegateCall(address(b), 50);


        assertEq(a.getVars(), 50);
        assertEq(b.getVar(), 0);
        console.log(a.getVars());
    }

    function testSetVarsCall() public {
        a.setVarsCall(address(b), 40);

        assertEq(a.getVars(), 0);
        assertEq(b.getVar(), 40);
}
}