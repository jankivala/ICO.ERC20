// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyJET is ERC20 {

    address public minter;

    constructor() ERC20('MyJET', 'JTN') { 
         minter = msg.sender;   
        _mint(minter, 100000000 * 10 ** 18);
    } 
}