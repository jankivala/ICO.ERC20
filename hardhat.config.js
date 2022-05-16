require("@nomiclabs/hardhat-waffle");

require('dotenv').config();

const INFURA_API_KEY = process.env.INFURA_API_KEY;

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
const ROPSTEN_PRIVATE_KEY = process.env.ROPSTEN_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.0",
  networks: {
    ropsten: {
      url: `${INFURA_API_KEY}` ,
      accounts: [`${ROPSTEN_PRIVATE_KEY}`]
    }
  }
};