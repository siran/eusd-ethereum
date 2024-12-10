// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract eUSD {
    string public name = "eUSD";
    string public symbol = "EUSD";
    uint8 public decimals = 18;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    address public immutable usdt;
    address public constant blackhole = 0x000000000000000000000000000000000000dEaD;

    constructor(address _usdt) {
        usdt = _usdt;
    }

    function mint(uint256 amount) external {
        require(amount > 0, "Zero amount");
        IERC20(usdt).transferFrom(msg.sender, blackhole, amount);
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Not enough eUSD");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}
