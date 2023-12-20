// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccesManagement.sol";
import "./TaskContract.sol";
import "./libraries/SafeMath.sol" ;
import "./libraries/Math.sol" ;


contract ManageReputation {
    // imported libraries 
    using SafeMath for uint256;
    using Math for int; 

    // Calculation
    uint scale = 1000000; 
    uint256 amountFactor; // decided by the group //byowner 
    uint256 effortFactor; // decided by the group


    // Imported contracts
    Admin public accessManagementInstance;
    TaskContract public  taskContractInstance;

    constructor( address _accesManagementContractAdress , address _taskContractInstance){
        accessManagementInstance = Admin(_accesManagementContractAdress);
        taskContractInstance = TaskContract(_taskContractInstance);

    }
    
    function calculateNewRep(string calldata _taskHash,address _worker,uint256 _completnessAvg , uint256 _qualityAvg ) public {
        // invoke this function by oracle after aggregation of evaluators done
        // managing access to contract 
        require(accessManagementInstance.isOracle(msg.sender)==true,"Only oracle can invoke this function");
        
        /**
        * @dev All calculations involving decimal numbers
        *      are done using a scaling factor .
        *
        * - we use in this version 10e6 as scaling factor .
        */

        // getting params
        uint256 amount = taskContractInstance.getTaskAmount(_taskHash);
        uint256 completnessFactor = taskContractInstance.getTaskCompletnessFactor(_taskHash);
        uint256 qualityFactor = taskContractInstance.getTaskQualityFactor(_taskHash);
        uint256 oldRep =  accessManagementInstance.getReputation(_worker); 
        uint256 numberOfSubmissions = accessManagementInstance.getNumberOfSubmissions(_worker); 
        uint256 minAvg = 5;

       
        amount = amount.sub(taskContractInstance.minAmount()).div(taskContractInstance.maxAmount().sub(taskContractInstance.minAmount()));
        
        require(completnessFactor.add(qualityFactor)== scale);

        uint256 effort = _completnessAvg.mul(completnessFactor).add(_qualityAvg.mul(qualityFactor));
        uint256 omega = uint256(Math.tanh(int256(numberOfSubmissions),int256(scale))); 

        require(amountFactor.add(effortFactor)== scale);
        
        // new task evaluation 
        uint256 newTask = amount.mul(amountFactor).add(effort); 

        // new reputation calculation
        if (_completnessAvg.add(_qualityAvg).div(2) < minAvg.mul(scale)){
            // Malicious behaviour
            // newRep = omega.mul(oldRep).add(scale.sub(omega).mul(newTask));
            // line deleted for compiler optimization (Stack too deep)
            updateRepuation(_taskHash, _worker, omega.mul(oldRep).add(scale.sub(omega).mul(newTask)));
        }
        else {
            // good  behaviour    
            // newRep = scale.sub(omega).mul(oldRep).add(omega.mul(newTask));
            // line deleted for compiler optimization (Stack too deep)
            updateRepuation(_taskHash, _worker, omega.mul(oldRep).add(scale.sub(omega).mul(newTask)));
        }
    }

    function updateRepuation(string calldata _taskHash  , address _worker , uint _newRep ) internal {
        // updateReputation
        accessManagementInstance.setReputation(_worker,_newRep); 
    }
}