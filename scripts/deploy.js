const { ethers } = require("hardhat");

async function main() {
  const WBTCDistributor = await ethers.getContractFactory("WBTCDistributor");

  const wbtc = await WBTCDistributor.deploy();

  await wbtc.deployed();

  console.log(`Contract deployed to: ${wbtc.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
