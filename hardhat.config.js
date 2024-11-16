require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    goerli: {
      url: process.env.NODE_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
};
