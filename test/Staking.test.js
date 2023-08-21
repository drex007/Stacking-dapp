const { expect, assert } = require("chai");
const { network, getNamedAccounts, deployments, ethers } = require('hardhat')
const { default: Web3 } = require('web3');

const convertToWei = (n) => {
  return ethers.utils.parseEther(n)

}

describe("StakingContract", async function () {
  let tokenContract, stakingContract

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners()
    const tokenContractFactory = await ethers.getContractFactory("TestToken")
    tokenContract = await tokenContractFactory.deploy()
    await tokenContract.deployed()
    const stakingContractFactory = await ethers.getContractFactory("TokenStaking")
    stakingContract = await stakingContractFactory.deploy(tokenContract.address)
    await stakingContract.deployed()

  })

  //Test for the testToken

  describe("testToken", async function () {
    it("check if token name is same with XXT", async function () {
      const tokenName = await tokenContract.getTokenSymbol()
      assert.equal("XXT", tokenName, "This two shoud be same")

    });
    it("check if total supply is 1000000", async () => {
      const tokenSupply = await tokenContract.total_supply()
      assert.equal(convertToWei(1000000), tokenSupply, "These two should be same")

    })
  });

  //Test for the staking contract

  describe("TokenStacking", async function () {
    it("Get the balance of the deployer", async function () {
      const stakingBalance = await stakingContract.balanceOf(stakingContract.address)
      assert.equal(convertToWei(500000), stakingBalance, "These balances should be same")
    })
  })

});
