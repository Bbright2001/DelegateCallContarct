// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract A{
    //STATE
    uint256 public num;
    address public sender;
    uint256 public value;
    
    receive() external payable {}


    //events
    event delegateCall(bool success, bytes  data);
    event call(bool success, bytes  data);

    //using delegate call to contract B
    function setVarsDelegateCall(address _contract, uint256 _num) public payable{
         
         (bool success, bytes memory data) = _contract.delegatecall(
             abi.encodeWithSignature("setVars(uint256)", _num)
         );
         emit  delegateCall(success, data);
}

//using call to contract B

function setVarsCall(address _contract, uint256 _num) public payable{
         
         (bool success, bytes memory data) = _contract.call{value: msg.value}(
            abi.encodeWithSignature("setVars(uint256)", _num)
         );

         emit call(success, data);
}

    function getVars() external view returns(uint256){
        return num;
    }
}