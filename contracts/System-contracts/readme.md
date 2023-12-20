# Proposed System Smart Contract Implementation

Welcome to the directory containing the smart contract implementation for our proposed system! This directory also includes the libraries used in the project.

## Contents

- `AccesManagement.sol`:  is a smart contract that manages access control and permissions within our decentralized application (DApp) . It is a common pattern used to control who can perform certain actions or access specific functionalities within the application.
The primary objective of `AccessManagement.sol` is to ensure that only authorized users or addresses are allowed to execute specific operations or access sensitive data, while restricting access to unauthorized users.
The contract provides the following functionalities:
	1.  **Role-Based Access Control (RBAC)**: It defines various roles within the system, such as "owner," "user," "oracle," etc. Each role is associated with specific privileges or permissions. For example, an "admin"  have the ability to validate users, while a "user"  have access to interact with the system .
    
	2.  **Role Assignment**: The contract allows designated administrators to assign roles to specific Ethereum addresses. This way, the contract can maintain a mapping of addresses to roles, enabling the system to check permissions efficiently.
    
	3.  **Access Modifiers**: The contract includes access modifiers (e.g., `onlyAdmin`, `onlyOracle`) that can be used in other contract functions. These modifiers check if the caller's address has the required role to execute the function. If not, the function call will fail, preventing unauthorized access .
	
	Overall, `AccessManagement.sol` plays a crucial role in ensuring that the application's security and integrity are maintained. By controlling access to various functionalities and data, it mitigates potential risks of unauthorized actions and data breaches within the decentralized system.

- `TaskContract.sol`: is a smart contract that facilitates the management of tasks on the blockchain network. It enables users to create, submit, complete, and interact with tasks in a decentralized manner. its implements the business logic behind the crowdsourcing senario .
- `ManageReputation.sol`:  The contract  serves as a component responsible for managing and tracking reputation scores participating in the system. its implement our proposed privacy preserving reputation model . for any extra infos about the formula and its variables , back to the final document report .
- `libraries/`: Contains the libraries used in the implementation process , you can acces the folder for more details .

## Contracts Deployment

![](https://img.shields.io/badge/Note-Important-red)

To facilitate smooth interaction between contracts, it is essential to carefully consider the deployment order. Since each contract needs the address of the other one to interact effectively, the deployment sequence becomes crucial for establishing the necessary dependencies.

To ensure proper contract interaction, follow this deployment order:

1.  Deploy the `AccessManagement` contract first.
2.  Once the `AccessManagement` contract is deployed and its address is obtained, deploy the `TaskContract` by providing the address of the `AccessManagement` contract as a parameter.
3.  After successfully deploying the `TaskContract`, you can proceed to deploy the `ManageReputation` contract, providing the addresses of both the `AccessManagement` and `TaskContract` contracts as parameters.

By adhering to this deployment order, you establish the required connections between contracts, enabling them to effectively interact with one another. Failing to follow this order may result in incorrect or incomplete contract interactions, leading to potential issues within the system. Therefore, it is crucial to carefully manage the deployment process to ensure a well-connected and fully functional smart contract ecosystem.
