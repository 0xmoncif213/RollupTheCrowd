# Oracle contracts
## Introduction
An Oracle contract is a smart contract within a blockchain ecosystem that acts as an intermediary or bridge between the blockchain and external data sources. Its primary purpose is to fetch, verify, and provide off-chain data to on-chain smart contracts, enabling them to interact with real-world information.

## Content 

- `APIConsumer.sol`:  The contract's role entails initiating a "GET" request towards the external adapter, facilitating the retrieval of off-chain data from IPFS . [details here](https://docs.chain.link/any-api/get-request/introduction) .
- `Operator.sol`: Oracles must deploy an on-chain contract to handle requests made through the LINK token . Refer to the [documentation](https://docs.chain.link/chainlink-nodes/contracts/operator) for additional operator functionalities.
