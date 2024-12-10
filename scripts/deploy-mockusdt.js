const { ethers } = require("hardhat");

async function main() {
  const MockUSDT = await ethers.getContractFactory("MockUSDT");
  const mock = await MockUSDT.deploy();
  await mock.waitForDeployment();
  const address = await mock.getAddress();
  console.log("Mock USDT deployed to:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
