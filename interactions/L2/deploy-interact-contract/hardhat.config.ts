import { HardhatUserConfig } from "hardhat/config";

import "@matterlabs/hardhat-zksync-deploy";
import "@matterlabs/hardhat-zksync-solc";

import "@matterlabs/hardhat-zksync-verify";

// dynamically changes endpoints for local tests
// const zkSyncTestnet =
//   process.env.NODE_ENV == "test"
//     ? {
//         url: "http://localhost:3050",
//         ethNetwork: "http://localhost:8545",
//         zksync: true,
//       }
//     : {
//         url: "https://zksync2-testnet.zksync.dev",
//         ethNetwork: "goerli",
//         zksync: true,
//         // contract verification endpoint
//         verifyURL:
//           "https://zksync2-testnet-explorer.zksync.dev/contract_verification",
//       };

const zkSyncTestnet = {
  url: "http://localhost:3050",
  ethNetwork: "http://localhost:8545",
  zksync: true,
}


const config: HardhatUserConfig = {
  zksolc: {
    version: "latest",
    settings: {
      libraries: {
        "contracts/SafeMath.sol": {
          SafeMath: "0x4B5DF730c2e6b28E17013A1485E5d9BC41Efe021",
        },
        "contracts/Math.sol": {
          Math: "0x111C3E89Ce80e62EE88318C2804920D4c96f92bb",
        },
     },
   },
  },
  defaultNetwork: "zkSyncTestnet",
  networks: {
    hardhat: {
      zksync: false,
    },
    zkSyncTestnet,
  },
  solidity: {
    version: "0.8.17",
  },
};

export default config;
