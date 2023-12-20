import { ethers, upgrades } from "hardhat";

async function main() {
    

    const math = await ethers.deployContract("Math");
    const safeMath = await ethers.deployContract("SafeMath");
    await safeMath.waitForDeployment();
    await math.waitForDeployment();
    console.log(math);


    const taskContractFactory = await ethers.getContractFactory("TaskContract", {
        libraries: {
          Math: math.target,
        },
      });

    let taskContract = await taskContractFactory.deploy();
    console.log("Task contract deployed to:", taskContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
