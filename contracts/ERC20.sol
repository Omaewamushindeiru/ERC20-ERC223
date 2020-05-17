pragma solidity >= 0.4.24;

import "./SafeMath.sol";
import "./FongibleToken.sol";

contract ERC20 is FongibleToken {

    using SafeMath for uint256;

    event Approval(address indexed owner, address indexed spender, uint256 indexed value);

    mapping (address => mapping (address => uint256)) private _allowed;

    constructor(string memory name, string memory ticker, uint totalSupply, uint8 decimals)
    FongibleToken(name,ticker,totalSupply,decimals) public { }


    function transfer(address _to, uint256 _value) public returns (bool)  {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        _transfer(_from, _to, _value);
        return true;
    }

    function _transfer(address from, address to, uint256 value) private {
        require(to != address(0), "address 0x0");

        require(value <= super.getBalances(from), "not enough fund");
        require(value <= _allowed[from][msg.sender], "transfer not allowed");

        super._transferValueInBalances(from, to, value);

        _allowed[from][msg.sender] -= value;

        emit Transfer(from, to, value);
    }


    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function _approve(address sender, address spender, uint256 value) internal {
        require(spender != address(0), "address 0x0");
        require(sender != address(0), "address 0x0");

        _allowed[sender][spender] = value;
        emit Approval(sender, spender, value);
    }

    function allowance(address sender, address spender) public view returns (uint256) {
        return _allowed[sender][spender];
    }
}