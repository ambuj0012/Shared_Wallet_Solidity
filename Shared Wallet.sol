// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

//  project guidelines-
//  1. This is a shared wallet project in solidity language
//  2. A shared wallet is a wallet owned combinedly by a group of peoples
//  3. One of them will be the owner of the wallet 
//  4. Owner of the wallet will have few upperhand among the other members
//  5. Anyone/Address can add/deposite funds in the contract
//  6. Owner of the contract can withdraw any sum of money from the contract
//  7. Other members(Non owners) will have a maximum amount of money which they can withdraw from the contract
//  8. They may withdraw that money in multiple transactions or in a single transaction its upto them

//  used cases-
//  1. This contract has many real world use cases 
//  2. Example- Money flow can be controlled in an organisation
//  3. The investor/head of a corporation/organisation can limit the money that can be spend by a particular entity, according to its requirement  


//  conditions-
//  1. mandatory to use fallback function to deposite funds
//  2. permissions to be given using modifiers

contract shared_wallet{


    // funds in this contract are in wei
        

    // declaring all the perons who have access to this wallet
    address owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address non_owner_1 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address non_owner_2 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address non_owner_3 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;

    // declaring maximum allowed allowance of the non owners
    uint maximum_allowance_of_non_owner_1 = 50; 
    uint maximum_allowance_of_non_owner_2 = 100;
    uint maximum_allowance_of_non_owner_3 = 150;

    // initiating the fund withdrawn by respective owners
    uint public fund_withdrawn_by_owner = 0;
    uint public fund_withdrawn_by_non_owner_1 = 0;
    uint public fund_withdrawn_by_non_owner_2 = 0;
    uint public fund_withdrawn_by_non_owner_3 = 0;

    // function to deposite funds to the wallet
    fallback()payable external{
    }
    
    // checking eligibility using modifiers
    modifier eligibility(){
        require(owner==msg.sender || non_owner_1==msg.sender || non_owner_2==msg.sender || non_owner_3==msg.sender,"your account is not eligible");
         _;
        }

    // function to check balance of the contract
    function check_balance() public view returns(uint){
        return address(this).balance;
    }
    
    // function to withdraw money
    function withdraw_funds(uint _x) payable public eligibility(){
        
        // transfer funds in owner's account
        if(owner==msg.sender){
            require(_x<= address(this).balance,"not enough balance");
               payable(msg.sender).transfer(_x);
               fund_withdrawn_by_owner = fund_withdrawn_by_owner + _x;
        }

        // transfer funds in non_owner_1's account
        if(non_owner_1==msg.sender){
            require(_x<= check_balance() && _x + fund_withdrawn_by_non_owner_1 <= 5,"you cannot withdraw");
               payable(msg.sender).transfer(_x);
               fund_withdrawn_by_non_owner_1 = fund_withdrawn_by_non_owner_1 + _x;
        }

        // transfer funds in non_owner_2's account
        if(non_owner_2==msg.sender){
            require(_x<= check_balance() && _x + fund_withdrawn_by_non_owner_2 <= 10,"cannot withdraw");
               payable(msg.sender).transfer(_x);
               fund_withdrawn_by_non_owner_2 = fund_withdrawn_by_non_owner_2 + _x;

        }

        // transfer funds in non_owner_3's account
        if(non_owner_3==msg.sender){
            require(_x<= check_balance() && _x + fund_withdrawn_by_non_owner_3 <= 15,"cannot withdraw");
                payable(msg.sender).transfer(_x);
                fund_withdrawn_by_non_owner_3 = fund_withdrawn_by_non_owner_3 + _x;
            
        }
    }
}