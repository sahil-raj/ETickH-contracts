// const hre = require("hardhat");

// async function main() {
//   const [deployer] = await hre.ethers.getSigners();
//   console.log("Deploying contract with account:", deployer.address);

//   const Contract = await hre.ethers.getContractFactory("EventFactory"); // Replace with your contract name
//   const contract = await Contract.deploy(); // Pass constructor arguments if needed
//   await contract.deployed();

//   console.log("Contract deployed to:", contract.address);
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // const balance = await deployer.getBalance();
  // console.log("Account balance:", balance.toString());

  const MyContract = await ethers.getContractFactory("EventFactory");
  const contract = await MyContract.deploy();
  console.log("Contract address:", await contract.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
