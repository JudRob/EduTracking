const MentoriaDescentralizada = artifacts.require("MentoriaDescentralizada.sol");

module.exports = function (deployer) {
  deployer.deploy(MentoriaDescentralizada);
};