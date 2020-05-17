pragma solidity >= 0.5.1;

import "./IERC223Recipient.sol";
import "./FongibleToken.sol";
import "./SafeMath.sol";
import "./Address.sol";

/**
 * @title Reference implementation of the ERC223 standard token.
 */
contract ERC223 is FongibleToken {
    using SafeMath for uint;

    event Transfer(address indexed from, address indexed to, uint256 indexed value, bytes _data);

    constructor(string memory name, string memory ticker, uint totalSupply, uint8 decimals)
    FongibleToken(name,ticker,totalSupply,decimals) public { }

    /**
     * @dev Transfer the specified amount of tokens to the specified address.
     *      Invokes the `tokenFallback` function if the recipient is a contract.
     *      The token transfer fails if the recipient is a contract
     *      but does not implement the `tokenFallback` function
     *      or the fallback function to receive funds.
     *
     * @param _to    Receiver address.
     * @param _value Amount of tokens that will be transferred.
     * @param _data  Transaction metadata.
     */
    function transfer(address _to, uint _value, bytes memory _data) public returns (bool success){
        // Standard function transfer similar to ERC20 transfer with no _data .
        // Added due to backwards compatibility reasons .
        super._transferValueInBalances(msg.sender, _to, _value);
        if(Address.isContract(_to)) {
            IERC223Recipient receiver = IERC223Recipient(_to);
            receiver.tokenFallback(msg.sender, _value, _data);
        }
        emit Transfer(msg.sender, _to, _value, _data);
        return true;
    }

    /**
     * @dev Transfer the specified amount of tokens to the specified address.
     *      This function works the same with the previous one
     *      but doesn't contain `_data` param.
     *      Added due to backwards compatibility reasons.
     *
     * @param _to    Receiver address.
     * @param _value Amount of tokens that will be transferred.
     */
    function transfer(address _to, uint _value) public returns (bool success){
        bytes memory empty = hex"00000000";
        super._transferValueInBalances(msg.sender, _to, _value);
        if(Address.isContract(_to)) {
            IERC223Recipient receiver = IERC223Recipient(_to);
            receiver.tokenFallback(msg.sender, _value, empty);
        }
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

}