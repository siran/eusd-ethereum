require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/0TiOe6GMha3DJgZuKB28nsaB03tr_Kn4",
      accounts: ["0xfa78dae17420ea72ce003c90f04d023aeee5df2f7ba58828aec47f6a69f722bc"]
    }
  }
};
