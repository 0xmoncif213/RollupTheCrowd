# Setup 

## Introduction

The `Setup/`directory  contains the initial configuration and installation scripts required to run the infrastructure needed for both layer1 and layer2 experimentations. 
To test the `layer1` setup of our project, you can utilize any Ethereum blockchain client. In our development process, we have specifically tested the contracts using  [Geth](https://geth.ethereum.org/) and  [Besu](https://besu.hyperledger.org/).

##  Layer1 Setup Instructions

1.  Install and configure the Ethereum client of your choice (e.g., Geth or Besu, ...).
2.  Deploy the contracts into your local or test network by following the instructions in `Contracts/` and `Interactions/` directories .
3.  Interact with and test the contracts.

### Testing Environment

-   **Ethereum Clients Tested**: Geth, Besu, ...
-   **Deployment Environment**: Local or test network

Feel free to explore and verify the functionality of our contract using the Ethereum client that best suits your needs.

## Layer2 Setup Instructions

The folder   `zkSync-local-node/`  holds all the steps required to run a local zkSync node which is used as a layer2 scaling solution. To deploy contracts on the node and interact with them please refer to `Interactions/L2` directory.
- For any extra info please refer to  [zkSync](https://docs.zksync.io/infra/running-node.html) local nodes documentation. 

##  Oracle Setup Instructions
The folders   `chainlink-docker-services/` and `chainlink-node-config/` contains the configuration and services used to run an oracle chainlink node.
- For any extra info please refer to  [Chainlink](https://docs.chain.link/chainlink-nodes) local nodes documentation. 
