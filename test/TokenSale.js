const { expect } = require('chai');

describe('MyContract', function () {
    let token;
    let accounts;
    const rate = ethers.utils.parseEther("1");

    beforeEach(async function () {
        const contract = await ethers.getContractFactory("TokenSale");
        token = await contract.deploy();

        accounts = await ethers.getSigners();
        await token.deployed();
    });

    describe("Deployment", function () {
        it("Should assign the total supply of tokens to the owner", async function () {
            
          const ownerBalance = await token.balanceOf(accounts[0].address);
          expect(await token.totalSupply()).to.equal(ownerBalance);

        });
      });

    describe("Transactions", function () {
        it("Buy tokens with ether", async function () {
            
            const wallet = token.connect(accounts[2]);
            const options = {value: rate};
            const calculate = (options.value).mul(238095);

            await wallet.buyTokens(options);
            expect(await wallet.balanceOf(accounts[2].address)).to.equal(calculate);

        });

        it("Should fail if sender doesn’t have enough tokens", async function() {

            const wallet = token.connect(accounts[3]);
            
            await expect(wallet.transfer(accounts[1].address, 1)).to.be.reverted;
           
        });

        it("Does not have enough ether to buy token", async function() {
            const wallet = token.connect(accounts[3]);
            const amount = ethers.utils.parseEther('999999');
            const options = {value: amount};
            let error;

            try {
                await wallet.buyTokens(options);
            }
            catch (err) {
                error = "sender does not have enough funds"
            }
            expect(error).to.equal('sender does not have enough funds');
        });
      });
});