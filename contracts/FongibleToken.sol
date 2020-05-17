pragma solidity >= 0.4.24;

import "./Ownable.sol";
import "./SafeMath.sol";

contract FongibleToken is Ownable {

    using SafeMath for uint256;

    event Transfer(address indexed from, address indexed to, uint256 indexed value);

    mapping (address => uint256) private _balances;

    function getBalances(address _of) internal view returns(uint256){
        return _balances[_of];
    }

    function _transferValueInBalances(address _from, address _to, uint value) internal returns(bool){
        _balances[_from] = _balances[_from].sub(value);
        _balances[_to] = _balances[_to].add(value);
        
        return true;
    }

    string private _name;
    string private _ticker;
    uint private _totalSupply;
    uint8 private _decimals;

    constructor(string memory name, string memory ticker, uint totalSupply, uint8 decimals)
    Ownable() public {
        _name = name;
        _ticker = ticker;
        _totalSupply = totalSupply;
        _decimals = decimals;
        _mint(owner(), _totalSupply);
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function ticker() public view returns (string memory) {
        return _ticker;
    }

    function balanceOf(address _address) public view returns (uint256) {
        return _balances[_address];
    }

    function transfer(address to, uint256 value) public returns (bool);

    function _mint(address _receiver, uint256 _value) internal onlyOwner() {
        require(_receiver != address(0), "address 0x0");
        _totalSupply = _totalSupply.add(_value);
        _balances[_receiver] = _balances[_receiver].add(_value);
        emit Transfer(address(0), _receiver, _value);
    }
}