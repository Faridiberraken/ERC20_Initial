// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    string public s_name = "Manual Token";
    uint256 public s_totalSupply = 100 ether;
    mapping(address=>uint256) public s_balances;

    function name() public view returns (string memory){
        return s_name;
    }
    function totalSupply() public view returns (uint256){
        return s_totalSupply;
    }

    function decimals() public pure returns (uint8){
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256 balance){
        return s_balances[_owner];
    }
    function transfer(address _to, uint256 _value) public returns (bool success){
        require(s_balances[msg.sender] >= _value);
        uint256 previousBalance = s_balances[msg.sender] + s_balances[_to];
        s_balances[msg.sender] -=_value;
        s_balances[_to] +=_value;
        require(previousBalance == s_balances[msg.sender] + s_balances[_to]);
        return true;
    }

}
