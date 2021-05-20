// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PhiAlphaBeta is ERC20 {

    address public minter;

    constructor() ERC20("5ABcoin", "5AB") {
        minter = msg.sender;
        _mint(minter, 1_000_000); // gives creator 1,000,000 5AB's
    }
    
    function assignMinter(address newMinter) public {
        require(msg.sender == minter, "only the minter can assign a new minter");
        minter = newMinter;
    }

    function mint(uint amount) public {
        require(msg.sender == minter, "only the minter can mint new coins");
        _mint(minter, amount);
    }
}