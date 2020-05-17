const marketPlace = artifacts.require('./Marketplace.sol');
const ERC20 = artifacts.require('./ERC20.sol');
const ERC721 = artifacts.require('./ERC721.sol');

let tryCatch = require("./exceptions.js").tryCatch;
let errTypes = require("./exceptions.js").errTypes;

const nameA = "TokenA"
const tickerA = "TKA"
const totalSupplyA = 10**12;
const decimalsA = 16

const nftPrice = 20

contract('Testing Markeplace 1 (ERC20)', function (accounts) {

    // Setup before each test
    beforeEach('setup contract for each test', async function () {
        // Deploying contract
        ERC20Instance = await ERC20.new( nameA, tickerA, totalSupplyA, decimalsA, {from: accounts[0]});
        ERC721Instance = await ERC721.new({from: accounts[0]});
        MarketPlaceInstance = await marketPlace.new(ERC20Instance.address, ERC721Instance.address, nftPrice, {from: accounts[0]});
    })

    // Tests routines start with "it"
    it('purchase token', async function (){

    // Creating an artist profile
    // function createConcert(uint _artistId, uint _venueId, uint _concertDate, uint _ticketPrice)
    await MarketPlaceInstance.purchaseNFT(accounts[0], {from: accounts[0]}); 

    // Retrieving newly created artists info
    retrievedERC721Info = await ERC721Instance._tokenOwner(1);

    // Checking the artists names
    assert.equal(web3.utils.toUtf8(retrievedERC721Info),accounts[0])



    })
})