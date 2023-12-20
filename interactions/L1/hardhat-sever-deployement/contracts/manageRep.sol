// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./admin.sol";
import "./taskContract.sol";
import "./SafeMath.sol" ;
import "./Math.sol" ;


contract ManageReputation {
    // imported libraries 
    using SafeMath for uint256;
    using Math for int; 

    // Calculation

    uint scale = 1000000; 
    uint256 amountFactor = 700000 ; // decided by the group //byowner 
    uint256 effortFactor = 300000; // decided by the group



    // Imported contracts
    Admin public accessManagementInstance ;
    TaskContract public  taskContractInstance ;

    constructor(){
        accessManagementInstance = Admin(0x194eF7d5fAFa22A108C0c4C22A6a3be6118E0c25);
        taskContractInstance = TaskContract(0x205A50955D80353AC61B46f140983b332626E5DD);

    }
    
    function calculateNewRep(string calldata _taskHash,address _worker,uint256 _completnessAvg , uint256 _qualityAvg) public  {
       
        uint256 amount = taskContractInstance.getTaskAmount(_taskHash);
        uint256 completnessFactor = taskContractInstance.getTaskCompletnessFactor(_taskHash);
        uint256 qualityFactor = taskContractInstance.getTaskQualityFactor(_taskHash);
        uint256 oldRep =  accessManagementInstance.getReputation(_worker); 
        uint256 numberOfSubmissions = accessManagementInstance.getNumberOfSubmissions(_worker); 
        uint256 minAvg = 5;

       
        amount = amount.sub(taskContractInstance.minAmount()).div(taskContractInstance.maxAmount().sub(taskContractInstance.minAmount()));
        
        // require(completnessFactor.add(qualityFactor)== scale);

        uint256 effort = _completnessAvg.mul(completnessFactor).add(_qualityAvg.mul(qualityFactor));
        uint256 omega = uint256(Math.tanh(int256(numberOfSubmissions),int256(scale))); 

        // //require(amountFactor.add(effortFactor)== scale);
        
        // // new task evaluation 
        uint256 newTask = amount.mul(amountFactor).add(effort); 

        // // new reputation calculation
        if (_completnessAvg.add(_qualityAvg).div(2) < minAvg.mul(scale)){
            // Malicious behaviour
            // newRep = omega.mul(oldRep).add(scale.sub(omega).mul(newTask));
            // line deleted for compiler optimization (Stack too deep)
            updateRepuation(_worker, omega.mul(oldRep).add(scale.sub(omega).mul(newTask)));
        }
        else {
            // good  behaviour    
            // newRep = scale.sub(omega).mul(oldRep).add(omega.mul(newTask));
            // line deleted for compiler optimization (Stack too deep)
            updateRepuation(_worker, omega.mul(oldRep).add(scale.sub(omega).mul(newTask)));
        }

    }

    function updateRepuation(address _worker , uint _newRep ) public  {
        // updateReputation
        accessManagementInstance.setReputation(_worker,_newRep); 
    }
}