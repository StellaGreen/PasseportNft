//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Passeport is ERC721 {

    // enum ?

    // struct

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // mapping of people is register
    mapping(uint256 => address) private _register;

    mapping(address => uint256) private _balances;

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
        _name =  name_;
        _symbol = symbol_;
    }

    // function

    function balanceOf (address user) public view return (uint256){
        require(user == _register, "balanceOf :you are not registred");
        require(owner != address(0), "balanceOf : balance query for the zero address");
    returns _balance[_register]
    }
}
