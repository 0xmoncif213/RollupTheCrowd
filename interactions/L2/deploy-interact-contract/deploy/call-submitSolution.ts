import { Provider } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";

// load env file
import dotenv from "dotenv";
dotenv.config();

// load contract artifact. Make sure to compile first!
import * as ContractArtifact from "../artifacts-zk/contracts/TaskContract.sol/TaskContract.json";

const PRIVATE_KEY = process.env.WALLET_PRIVATE_KEY || "";

if (!PRIVATE_KEY)
  throw "⛔️ Private key not detected! Add it to the .env file!";

// Address of the contract on zksync testnet
const CONTRACT_ADDRESS = "0x094499Df5ee555fFc33aF07862e43c90E6FEe501";
                          

if (!CONTRACT_ADDRESS) throw "⛔️ Contract address not provided";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running script to interact with contract ${CONTRACT_ADDRESS}`);

  // Initialize the provider.
  // @ts-ignore
  const provider = new Provider(hre.userConfig.networks?.zkSyncTestnet?.url);
  const signer = new ethers.Wallet(PRIVATE_KEY, provider);

  // Initialize contract instance
  const contract = new ethers.Contract(
    CONTRACT_ADDRESS,
    ContractArtifact.abi,
    signer,
  );

  // send transaction to add another owner
  const taskHash = "745861e6a022d6c8e35a4b073c389d0dd4ce6aa1";
  const bidHash = "745861e6a022d6c8e35a4b073c389d0dd4ce6aa1";
  const solHash= "745861e6a022d6c8e35a4b073c389d0dd4ce6aa1";
  const startTime: number = new Date().getTime();
  
//   for (let i: number = 0; i < 5; i++) {
    var tx = await contract.submitSolution(taskHash,bidHash,solHash);
//   }

  const endTime: number = new Date().getTime();
  const timeDiff: number = endTime - startTime;
  console.log(timeDiff);
  console.log(`Transaction to add another owner is ${tx.hash}`);

}
