const SafeMath = artifacts.require("SafeMath");
const MarketplaceA = artifacts.require("Marketplace");
const MarketplaceB = artifacts.require("Marketplace");
const Address = artifacts.require("Address");
const Counters = artifacts.require("Counters");
const ERC721 = artifacts.require("ERC721");
const ERC20 = artifacts.require("ERC20");
const ERC223 = artifacts.require("ERC223");

const nameA = "TokenA";
const tickerA = "TKA";
const totalSupplyA = 10**12;
const decimalsA = 16;

const nameB = "TokenB";
const tickerB = "TKB";
const totalSupplyB = 10**12;
const decimalsB = 16;

const nftPrice = 20;

module.exports = function(deployer) {
  deployer.deploy(SafeMath)
  .then(() => deployer.link(SafeMath, [Counters, ERC20, ERC223, ERC721, MarketplaceA, MarketplaceB]))
  .then(() => deployer.deploy(Counters))
  .then(() => deployer.link(Counters, ERC721))
  .then(() => deployer.deploy(Address))
  .then(() => deployer.link(Address, ERC223))
  .then(() => deployer.deploy(ERC20, nameA, tickerA, totalSupplyA, decimalsA))
  .then(() => deployer.link(ERC20, MarketplaceA))
  .then(() => deployer.deploy(ERC223,  nameB, tickerB, totalSupplyB, decimalsB))
  .then(() => deployer.link(ERC223, MarketplaceB))
  .then(() => deployer.deploy(ERC721))
  .then(() => deployer.link(ERC721, [MarketplaceA, MarketplaceB]))
  .then(() => deployer.deploy(MarketplaceA, ERC721.address, ERC20.address, nftPrice))
  .then(() => deployer.deploy(MarketplaceB, ERC721.address, ERC223.address, nftPrice));
};
