const { ethers } = require("hardhat");

async function main() {
  const transferContr = await ethers.getContractFactory("SignatureTransferContract");

  const c = await transferContr.deploy();

  await c.deployed();

  console.log(`Contract deployed to: ${c.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
