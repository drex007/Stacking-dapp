// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;
import "./Token.sol";

contract TokenStaking{

    string public name = "Yield Farming / Token Dapp";
    TestToken public testToken;
     //
     address public owner;
    // % Rturns for stakes
     uint256 public defaultAPY = 100;
     uint256 public customAPY = 137;

    // Stakes, Custom and Normal Stakes
     uint256 public totalStaked;
     uint256 public customTotalStaked;

     mapping(address =>uint256) public stakingBalance;
     mapping(address =>uint256) public customStakingBalance;

      //mapping list of users who ever staked
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public customHasStaked;

    //mapping list of users who are staking at the moment
    mapping(address => bool) public isStakingAtm;
    mapping(address => bool) public customIsStakingAtm;

    address[] public stakers;
    address[] public customStakers;


        
    constructor(TestToken _testToken){
        testToken =_testToken;
        owner = msg.sender;
    }

    function stakeToken(uint256 _amount) public{
        require(_amount > 0, "Amount must be greater than 0");
        require(hasStaked[msg.sender]== false, "You can only stake once");
        testToken.transferFrom(msg.sender, address(this), _amount);
        totalStaked = totalStaked + _amount;
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;
        // if (!hasStaked[msg.sender]) {
        //     stakers.push(msg.sender);
        // }
        stakers.push(msg.sender);

        hasStaked[msg.sender] = true;
        isStakingAtm[msg.sender] = true;

    }

     function unstakeTokens() public {
        //get staking balance for user

        uint256 balance = stakingBalance[msg.sender];

        //amount should be more than 0
        require(balance > 0, "amount has to be more than 0");

        //transfer staked tokens back to user
        testToken.transfer(msg.sender, balance);
        totalStaked = totalStaked - balance;

        //reseting users staking balance
        stakingBalance[msg.sender] = 0;

        //updating staking status
        isStakingAtm[msg.sender] = false;
     }

    function customStaking(uint56 _amount) public {
        require(_amount > 0, "Amount cannot be 0");
        require(customHasStaked[msg.sender] == false, "You cannot stake twice");
        testToken.transferFrom(msg.sender, address(this), _amount);
        customTotalStaked = customTotalStaked + _amount;
        customStakingBalance[msg.sender] = customStakingBalance[msg.sender] + _amount;
        customStakers.push(msg.sender);
        //The second require statment does that
        //  if (!customHasStaked[msg.sender]) {
        //     customStakers.push(msg.sender);
        // }
        customHasStaked[msg.sender] = true;
        customIsStakingAtm[msg.sender]= true;
        

    }

    function customUnstake() public{
        uint256 balance = customStakingBalance[msg.sender];
        require(balance > 0, "Balance must be greater than 0");
        testToken.transfer(msg.sender, balance);
        customTotalStaked = customTotalStaked - balance;
        customStakingBalance[msg.sender]=0;
        customIsStakingAtm[msg.sender] = false;

    }
   
   // Airdrops

    function redistributeReWards() public{
        require(msg.sender == owner, "Only owners are permitted to this functions");
        for (uint256 i=0; i < stakers.length; i++){
            address recipient = stakers[i];
            uint256 balance = stakingBalance[recipient] * defaultAPY;
            balance = balance / 100000;
            if (balance > 0){
                testToken.transfer(recipient, balance);
            }

        }

    }

    //Custom Airdrops

     function customRewards() public {
        require(msg.sender == owner, "Only contract creator can redistribute");
        for (uint256 i = 0; i < customStakers.length; i++) {
            address recipient = customStakers[i];
            uint256 balance = customStakingBalance[recipient] * customAPY;
            balance = balance / 100000;

            if (balance > 0) {
                testToken.transfer(recipient, balance);
            }
        }
    }

    function changeAPY(uint64 _value) public {
        require(msg.sender == owner, "Only contract owners can access this function");
        require(_value > 0, "APY Value must be greater than 100");
        customAPY = _value;

    }

     function claimTst() public {
        address recipient = msg.sender;
        uint256 tst = 1000000000000000000000;
        uint256 balance = tst;
        testToken.transfer(recipient, balance);
    }







}