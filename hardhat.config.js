require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const { ALCHEMY_SEPOLIA_RPC_URL, WALLET_PRIVATE_KEY, ETHERSCAN_API_KEY, LOCALHOST_KEY } = process.env;

console.log(ALCHEMY_SEPOLIA_RPC_URL);

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  },
  networks: {
    // sepolia: {
    //   // chainId: 11155111,
    //   url: ALCHEMY_SEPOLIA_RPC_URL,
    //   accounts: [WALLET_PRIVATE_KEY],
    //   blockGasLimit: 1,
    //   gasPrice: 500000,
    // },
    localhost: {
      chainId: 31337,
      url: "http://127.0.0.1:8545/",
      accounts: [LOCALHOST_KEY]

    }
  }
};
