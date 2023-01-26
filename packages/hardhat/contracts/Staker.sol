// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;


import "hardhat/console.sol";
import "./ExampleExternalContract.sol";


/**
*@title Staker.
*@author ABossOfMyself.
*@notice Created a Staking smart contract.
*/


contract Staker {

    ExampleExternalContract public exampleExternalContract;


    event Stake(address indexed staker, uint256 indexed stakedAmount);


    mapping(address => uint256) public balances;
    

    address[] public stakers;

    uint256 public constant threshold = 1 ether;

    uint256 public deadline = block.timestamp + 144 hours;

    bool public openForWithdraw;
  


    constructor(address exampleExternalContractAddress) {

        exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
    }



    function stake() public payable {

      balances[msg.sender] += msg.value;

      stakers.push(msg.sender);

      emit Stake(msg.sender, msg.value);
    }



    function execute() public {

      require(block.timestamp >= deadline, "Please wait!");

      if(address(this).balance >= threshold) {

        exampleExternalContract.complete{value: address(this).balance}();

      } else {

        openForWithdraw = true;
      }
    }



    function withdraw() public {

      if(openForWithdraw == true) {

        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");

        require(success, "Transfer failed!");

        openForWithdraw = false;
      }
    }



    function timeLeft() public view returns(uint256) {

      if(block.timestamp >= deadline) {

        return 0;

      } else {

        return deadline - block.timestamp;
      }
    }

    
    
    receive() external payable {

      stake();
    }
  }