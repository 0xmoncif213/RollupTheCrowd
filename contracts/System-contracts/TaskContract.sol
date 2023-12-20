// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0 ;

import "./AccesManagement.sol";
import "./libraries/SafeMath.sol" ;
import "./libraries/Math.sol" ;


contract TaskContract {
    // imported libraries 
    using SafeMath for uint256;
    using Math for int   ; 

    // Imported contract
    Admin public accessManagementInstance ;
    
    // State varibales 
    mapping (string => Task) public tasks;
    uint256 public maxAmount ; 
    uint256 public minAmount ;
    uint256 public lastAmount ;

    struct BidProgress {
        bool exist ;
        bool answer;
        string submission;
    }
    struct Task{
        string taskID;  
        address requester;
        address [] workers;
        address [] evaluators;
        mapping (uint => address[]) evaluatorSets; // each set is responsible for evaluating a single submission       
        uint256 amount; 
        uint256 completnessFactor;
        uint256 qualityFactor;
        string[] bids; 
        uint256 maxBids;
        mapping(string => BidProgress) bidProgress;
        mapping (string => address) bidSubmitter;
        mapping(address => bool ) workerExist; 
        bool exist ; 
    }
     struct Bid {
        address user ;
        string taskID ;
        string bidID ; 
        string description ; 
        fixed128x18 deposit ; 
        uint256 duration ; 
        fixed128x18 bidPrice ;

    }
    
    struct Submission {
        address user ;  
        string taskID ; 
        string submissionID ; 
        string answerHash ; 
        uint256 submissionTime  ; 
    }

        
    constructor(address _AccesManagementContractAdress){
        accessManagementInstance = Admin(_AccesManagementContractAdress);
    }

    function  createTask(string calldata _taskHash , uint256 _amount ) public {
        // vrify existence of user
        require(accessManagementInstance.isUser(msg.sender)==true , "only registred users can create task");
        // adding task hash  and id to the mapping from idtoHash
        //assing requester creating a task 
        tasks[_taskHash].requester = msg.sender ;
        tasks[_taskHash].exist = true; // replace hash with task ID 
        
        // Update amount 
        //First transaction hundling
        if(maxAmount==0){
            minAmount = 0 ;
            maxAmount = _amount;
            lastAmount = _amount ;
        }
        //second transaction hundling
        else if (minAmount==0) {
            minAmount = Math.min(lastAmount,_amount);
            maxAmount = Math.max(maxAmount,_amount);
        }
        //rest of transaction hundling
        else {
            minAmount = Math.min(minAmount,_amount);
            maxAmount = Math.max(maxAmount,_amount);
        }

    }

    function createBid(string calldata _taskHash ,string calldata _bidHash) public {
        require(tasks[_taskHash].exist==true, "Task doesn't exist");  //task exist 
        require(accessManagementInstance.isUser(msg.sender)==true , "only registred users can submit bids");
        require(tasks[_taskHash].requester != msg.sender , "requester can't submit bids for his own task");
        //push worker to task 
        tasks[_taskHash].workers.push(msg.sender); 
        tasks[_taskHash].bidSubmitter[_bidHash] = msg.sender ; 
        //push bid to task 
        tasks[_taskHash].bids.push(_bidHash);
        tasks[_taskHash].bidProgress[_bidHash].exist = true ; 
        tasks[_taskHash].bidProgress[_bidHash].answer = false ; 
        // get bid from ipfs :)
    }

    function createAnswer(string calldata _taskHash , string calldata _bidHash, bool _answer ) public {
        require(tasks[_taskHash].exist==true, "Task doesn't exist"); 
        require(tasks[_taskHash].requester==msg.sender,"Only requester can answer bids");
        require(tasks[_taskHash].bidProgress[_bidHash].exist == true, "Bid doesn't exist"); 
        tasks[_taskHash].bidProgress[_bidHash].answer = _answer ; 
    }

    function submitSolution(string calldata _taskHash , string calldata _bidHash , string calldata _solutionHash) public {
        require(tasks[_taskHash].bidSubmitter[_bidHash] == msg.sender, "worker submit solution to his own bid");
        require(tasks[_taskHash].bidProgress[_bidHash].answer == true, "only authorized bids can accept solutions");
        tasks[_taskHash].bidProgress[_bidHash].submission = _solutionHash ;

    }
    function participateInEvaluation (string calldata _taskHash , string calldata _bidHash , string calldata _solutionHash ) public {
        require(tasks[_taskHash].requester != msg.sender , "requester can't participate in evaluation of his own task");
        // expertise needed (we'll add it later)
        require(tasks[_taskHash].bidProgress[_bidHash].exist == true, "Bid doesn't exist"); 
        require(tasks[_taskHash].bidSubmitter[_bidHash] != msg.sender, "worker can't evaluate his own solution");

        // requirements for being evaluator (Minimum reputation) remove comment below
        
        // uint minimumRep = YOUR_SYSTEM_MIN_REP;
        // require(accessManagementInstance.getReputation(msg.sender)>= minimumRep, "Evaluator not qualified");

        // adding user to evaluators
        tasks[_taskHash].evaluators.push(msg.sender);  

    }

    function distributeEvaluatorsToRandomSets(address[] memory _evaluators, uint256 _numSets , string calldata _taskHash)public {
        // verify caller is an oracle 
        require(accessManagementInstance.isOracle(msg.sender)== true , "Only oracle can call this contract");
        // number of sets reffers to number of submissions 
        // Shuffle the array randomly to prevent evaluators guessing
        for (uint256 i = 0; i < _evaluators.length; i++) {
        uint256 n = i + uint256(keccak256(abi.encodePacked(block.timestamp))) % (_evaluators.length - i);
        address temp = _evaluators[n];
        _evaluators[n] = _evaluators[i];
        _evaluators[i] = temp;
    }
        // Distributing the evaluators into diffirent sets 
        for (uint256 i=0; i<  _evaluators.length;i++){
           tasks[_taskHash].evaluatorSets[i%_numSets].push(_evaluators[i]);
        }
    }


    function getTaskAmount(string calldata _taskHash) public view returns (uint256) {
        return tasks[_taskHash].amount;
    }
    function getTaskCompletnessFactor(string calldata _taskHash) public view returns (uint256) {
        return  tasks[_taskHash].completnessFactor;
    }
    function getTaskQualityFactor(string calldata _taskHash) public view returns (uint256) {
        return  tasks[_taskHash].qualityFactor;
    }


}
