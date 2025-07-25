// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract B{
    //STATE
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }

     function getVar() external view returns(uint256){
        return num;
    }
}