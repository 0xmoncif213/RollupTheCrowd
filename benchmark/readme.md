
# Benchmarks using Hyperledger Caliper

 ## Guide 
 
Each directory houses specialized performance tests for the respective functions we aimed to assess. These tests have been implemented for the specific use case and are within the `workload/` directory of each benchmark . The specific tests to be executed and their configurations are outlined in the `Function_to_be_tested-benchmarks/config/caliper-benchconfig.yaml` file. Additionally, the connection details for the besu network (test network), including the designated channel and user, are specified in the `config/caliper-networkconfig.yaml` file.

## For Running benchmark tests using Hyperledger Caliper

To reproduce the tests and view the results, follow these steps:

1. Run your network and deploy the contracts as mentioned in [System-contracts directory](../contracts/System-contracts/) . 
2. Clone this repository and navigate to the `benchmark/` folder . 
3. Install Hyperledger Caliper [Instructions here](https://hyperledger.github.io/caliper/v0.5.0/installing-caliper/#using-the-docker-image) . 
4. Verify that the configuration files match the expected configuration, you'll need to compare the content of the configuration files with the expected configuration settings.
5. Update the `volumes` variable in the `docker-compose.yaml` file based on the specific function for which you intend to run tests.
6. Run `docker-compose up` .
