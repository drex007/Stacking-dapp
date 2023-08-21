// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;

contract TestToken {
    address public owner;
    string public name = "Xext Token";
    string public symbol = "XXT";
    uint256 public total_supply = 1000000000000000000000000; // 1million token supply /18
    uint8 public decimals = 18;
    address internal cUsdTokenAddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    //events
     event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    event Approval(
            address indexed _owner,
            address indexed _spender,
            uint256 _value
    );

    mapping (address => uint256) public balanceOf;
    mapping(address => mapping (address => uint256)) public allowance;
    
    constructor (){
        balanceOf[msg.sender] = total_supply; // Assing the totalSupply balance to the contract owner
    }

    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender] >= _value); // Ensure senders wallet is greater that vaue
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] +=_value;
        emit Transfer(msg.sender, _to, _value);
        return success;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function getTokenSymbol() public view  returns(string memory) {
        return symbol;
    }

}