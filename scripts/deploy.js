const hre = require("hardhat");
require('dotenv').config()



const { ALCHEMY_SEPOLIA_RPC_URL, WALLET_PRIVATE_KEY, ETHERSCAN_API_KEY, LOCAL_WALLET } = process.env;
async function main() {
  console.log(LOCAL_WALLET, "WALEEEEEEEE");

  const tokenContractInstance = await hre.ethers.getContractFactory("TestToken");
  const stakingContractInstance = await hre.ethers.getContractFactory("TokenStaking");

  const tokenContract = await tokenContractInstance.deploy()
  // await tokenContract.deployed()
  console.log(tokenContract.address, "Token Contract adress");

  const stakingContract = await stakingContractInstance.deploy(tokenContract.address)
  // await stakingContract.deployed()
  await tokenContract.transfer(stakingContract.address, "500000000000000000000000") // Divide by 1*10**18 = 500k
  await tokenContract.transfer(LOCAL_WALLET, '1000000000000000000000'); //=1k
  console.log(stakingContract.address, "Staking Contract adress");

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
