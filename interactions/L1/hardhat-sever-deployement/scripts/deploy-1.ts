import { ethers } from "hardhat";

async function main() {
  const admin = await ethers.deployContract("Admin");
  await admin.waitForDeployment();
  admin.deploymentTransaction()?.gasPrice
  console.log("Reputation Contract deployed to:", admin.target);
  

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
