const DiplomeManager = artifacts.require("DiplomeManager");

module.exports = function (deployer) {
  deployer.deploy(DiplomeManager);
}