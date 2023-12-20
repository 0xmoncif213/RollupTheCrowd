// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Admin {
    
    address private admin;
    address  [] public adminsList ; 
    mapping(address => bool) public adminExist;
 
    address payable [] public accountlist;
    mapping (address => User) public accountslist;
    address payable [] public pendingList;
    mapping (address => bool) public accountsPending;

    address [] private oracleAdresses; 
    mapping (address => bool) private oracleExist ; 

    
    struct User {
        address payable userAdress; 
        uint reputation; 
        uint numberOfSubmissions ;
        bool exist; 
        // string [] expertise ;
    }

    function createAccount(address payable _address) public {
    require(accountsPending[_address]==false);
    pendingList.push(_address);
    accountsPending[_address]=true;
    }


    constructor() {
        admin = msg.sender;
        adminsList.push(admin); 
        adminExist[admin]= true;
        accountlist.push(payable(admin)); 
        accountslist[admin]= User(payable(admin),0,0,true);
        oracleAdresses.push(admin);
        oracleExist[admin]=true;
    }

    modifier onlyOwner() {
        require(adminExist[msg.sender] == true, "Only the contract owner can call this function.");
        _;
    }

    modifier onlyOracle() {
        require(oracleExist[msg.sender] == true, "Only the oracle can call this function.");
        _;
    }

    function addOwner(address _newOwner) public onlyOwner {
        adminsList.push(_newOwner); 
        adminExist[_newOwner]= true;
    }

    function validateUser(address payable  _newUser  ) public onlyOwner(){
        require(accountsPending[_newUser]==true);
        accountlist.push(_newUser); 
        accountslist[_newUser]= User(_newUser,0,0,true);
        
    }
    
    function addOracleAdress(address _address) public onlyOwner(){
        oracleAdresses.push(_address);
        oracleExist[_address]=true;
    }

    function setReputation(address _user , uint256 _newRep) public{
        accountslist[_user].reputation = _newRep; 
    }

    function isOwner(address _user) public view returns (bool) {
        return adminExist[_user];
    }
   
    // Restrict to admin using only admin modifier if needed 
    function isPending(address _user) public view  returns (bool) {
        return accountsPending[_user];
    }
    
    function isUser(address _user) public view returns  (bool){
        return accountslist[_user].exist; 
    }

    function getReputation(address _user) public view returns(uint256){
        return accountslist[_user].reputation; 
    }

    function getNumberOfSubmissions(address _user) public view returns(uint256){
        return accountslist[_user].numberOfSubmissions; 
    }

    function isOracle(address _address)public view returns (bool){
        return oracleExist[_address];
    }
}

