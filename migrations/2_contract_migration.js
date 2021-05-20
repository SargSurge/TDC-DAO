const TDCdao = artifacts.require("TDCdao");
const PhiAlphaBeta = artifacts.require("PhiAlphaBeta");

module.exports = function (deployer) {
  // deployer.deploy(TDCdao);
  deployer.deploy(PhiAlphaBeta);
};
