// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./MyJET.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title ico for MyJET token

contract TokenSale is MyJET, Ownable {

    uint256 unitsofToken = 238095;
    uint256 public finalsalePrice = 2380;

    /// @notice amount is the token bought by the sender
    uint256 public amount;
    uint256 public tokensSold;
    uint256 public availableTokens = 30000000 * 10 ** 18;

    uint256 seedSaleToken = 50000000 * 10 ** 18;
    uint256 finalSaleToken = 20000000 * 10 ** 18;

    enum Stages {
        PreICO,
        ICO,
        FinalICO
    }

    Stages public stage;

    /// @notice it will set the sale phase
    function setStage() internal {
        if ( stage == Stages.PreICO && availableTokens == 0) {
            stage = Stages.ICO;
            unitsofToken = 120481;
            availableTokens = seedSaleToken;
        } else if ( stage == Stages.ICO && availableTokens == 0 ) {
            stage = Stages.FinalICO;
            unitsofToken = finalsalePrice;
            availableTokens = finalSaleToken;
        }
    }

    /// @notice this function will tansfer tokens 
    function buyTokens() external payable {
        
        require(msg.value != 0, "ethAmount cannot be zero");

        amount = msg.value * unitsofToken;
        tokensSold += amount;
        availableTokens -= amount;

        if ( availableTokens == 0 ) {
            setStage();
        }

        /// @notice transfer the token to the buyer
        _transfer(minter, msg.sender, amount);

        /// @notice send the ether earned to the token owner
        payable(minter).transfer(msg.value);
    }

    function setfinalSalePrice(uint256 _finalSalePrice) external onlyOwner {
                finalsalePrice = _finalSalePrice;
    }

    function getfinalSalePrice() external view returns(uint256) {
        return finalsalePrice;
    }
}