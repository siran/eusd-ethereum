// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface IUSDT {
    // Minimal USDT interface needed for minting:
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract eUSD is IERC20 {
    string public name = "eUSD";
    string public symbol = "EUSD";
    uint8 public decimals = 6; // fiat-like decimals, matches USDT

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    address public immutable usdt;
    address public constant blackhole = 0x000000000000000000000000000000000000dEaD;

    constructor(address _usdt) {
        usdt = _usdt;
    }

    // Mint new eUSD by burning USDT from the caller's account.
    // Caller must have called USDT's approve(eUSD_address, amount) beforehand.
    function mint(uint256 amount) external {
        require(amount > 0, "Zero amount");
        // Burn USDT:
        IUSDT(usdt).transferFrom(msg.sender, blackhole, amount);

        // Mint eUSD:
        _balances[msg.sender] += amount;
        _totalSupply += amount;

        emit Transfer(address(0), msg.sender, amount);
    }

    // Standard ERC20 functions:

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        require(_balances[msg.sender] >= amount, "Not enough eUSD");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(_balances[sender] >= amount, "Not enough eUSD");
        require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    // Events as per ERC20 standard:
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
