// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {A} from "../src/contractA.sol";
import {B} from "../src/contractB.sol";


contract DelegateCallScript is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy contracts
        A contractA = new A();
        B contractB = new B();

        console.log("Contract A deployed at:", address(contractA));
        console.log("Contract B deployed at:", address(contractB));

        // Fund A with ether
        payable(address(contractA)).transfer(0.05 ether);

        // Log storage before any function calls
        console.log("== Initial Storage ==");
        console.log("A.num:", contractA.num());
        console.log("A.sender:", contractA.sender());
        console.log("A.value:", contractA.value());
        console.log("B.num:", contractB.num());
        console.log("B.sender:", contractB.sender());
        console.log("B.value:", contractB.value());

        // Perform .call to B from A
        console.log("Calling setVarsCall with 0.01 ether and num = 42");
        contractA.setVarsCall{value: 0.01 ether}(address(contractB), 42);

        // Log after call
        console.log("== After setVarsCall ==");
        console.log("A.num:", contractA.num());
        console.log("A.sender:", contractA.sender());
        console.log("A.value:", contractA.value());
        console.log("B.num:", contractB.num());
        console.log("B.sender:", contractB.sender());
        console.log("B.value:", contractB.value());

        // Perform delegatecall
        console.log("Calling setVarsDelegateCall with 0.01 ether and num = 123");
        contractA.setVarsDelegateCall{value: 0.01 ether}(address(contractB), 123);

        // Log after delegatecall
        console.log("== After setVarsDelegateCall ==");
        console.log("A.num:", contractA.num());
        console.log("A.sender:", contractA.sender());
        console.log("A.value:", contractA.value());
        console.log("B.num:", contractB.num());
        console.log("B.sender:", contractB.sender());
        console.log("B.value:", contractB.value());

        vm.stopBroadcast();
    }
}


