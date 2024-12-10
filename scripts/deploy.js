const { ethers } = require("hardhat");

async function main() {
  const USDT_ADDRESS = "0x7d713915d029f8BD10E0Cf181dF6449ac93dffC2";
  const EUSD = await ethers.getContractFactory("eUSD");
  const eusd = await EUSD.deploy(USDT_ADDRESS);
  await eusd.waitForDeployment(); // replaces eusd.deployed()

  const address = await eusd.getAddress();
  console.log("eUSD deployed to:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
