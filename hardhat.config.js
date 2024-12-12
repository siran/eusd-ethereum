require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { ALCHEMY_API_KEY, PRIVATE_KEY, ETHERSCAN_API_KEY} = process.env;

module.exports = {
  solidity: "0.8.28",
  networks: {
    mainnet: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  }
};
