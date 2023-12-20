import { ethers, upgrades } from "hardhat";

async function main() {
    const math = await ethers.deployContract("Math");
    const safeMath = await ethers.deployContract("SafeMath");
    await safeMath.waitForDeployment();
    await math.waitForDeployment();
    console.log(math);


    const repContractFactory = await ethers.getContractFactory("ManageReputation", {
        libraries: {
          Math: math.target,
        },
      });

    let repContract = await repContractFactory.deploy();
    console.log("Reputation Contract deployed to:", repContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
