const TutoriaDescentralizada = artifacts.require("edu_tracking.sol");

module.exports = function (deployer) {
  deployer.deploy(edu_tracking);
};