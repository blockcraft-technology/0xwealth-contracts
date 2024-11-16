require("dotenv").config();
const { ethers } = require("hardhat");

async function main() {
  //const contractAddress = "0xC5337288c1c60c0f628E57CfB5f6a998784759bc";
  const contractAddress = "0x45Caa99622dB283b24cA5D9A48cE68BB54b44110";
  const destination = ethers.utils.getAddress("0x7e5aec2b002faca46a278025e0c27b4e481cff24");
  const amount = 1;

  const provider = new ethers.providers.JsonRpcProvider(process.env.NODE_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  const abi = [
    "function payout(address destination, uint256 amount) external",
  ];
  const contract = new ethers.Contract(contractAddress, abi, wallet);

  console.log(`Transferring ${amount} satoshis of WBTC to ${destination}...`);
  const tx = await contract.payout(destination, amount);
  console.log(`Transaction sent: ${tx.hash}`);

  const receipt = await tx.wait();
  console.log(`Transaction confirmed in block ${receipt.blockNumber}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
