pragma solidity >=0.4.24;

import "./Ownable.sol";
import "./SafeMath.sol";
import "./ERC721.sol";
import "./FongibleToken.sol";

contract Marketplace is Ownable{

    uint private _currentId;

    ERC721 private _erc721;
    FongibleToken private _token;

    uint _nftPrice;

    constructor(ERC721 erc721, FongibleToken token, uint nftPrice) public {
        _erc721 = erc721;
        _token = token;
        _nftPrice = nftPrice;
    }

    function purchaseNFT(address to) public returns (bool) {
        require(_token.balanceOf(msg.sender) >= _nftPrice, "not enough peels owned");

        _token.transfer(_token.owner(), _nftPrice);

        _currentId++;

        _erc721.mintToken(to, _currentId);

        return true;
    }

}

