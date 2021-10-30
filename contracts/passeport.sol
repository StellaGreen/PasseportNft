//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Passeport is ERC721 {

        // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // mapping of people is register
    mapping(uint256 => address) private _register;

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
        _name =  name_;
        _symbol = symbol_;
    }

    // enum ?

    // struct

    // function
}
