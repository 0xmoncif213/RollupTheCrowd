import * as dotenv from "dotenv";
import { HardhatUserConfig } from "hardhat/config";
import "@openzeppelin/hardhat-upgrades";

dotenv.config()

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{
      version: "0.8.0"
    }],
    settings: {
      optimizer: {
        enabled: true,
        runs: 2000,
      }
    },
  },
  networks: {
    besu: {
      url: "http://172.17.0.1:8545",
      accounts:
        ["0xae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f"],
    },
  },
  
};

export default config;

