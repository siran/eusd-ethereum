const { ethers } = require("hardhat");

async function main() {
  // Mainnet USDT address
  const USDT_ADDRESS = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
  const EUSD = await ethers.getContractFactory("eUSD");
  const eusd = await EUSD.deploy(USDT_ADDRESS);
  await eusd.waitForDeployment();
  console.log("eUSD deployed to:", await eusd.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
