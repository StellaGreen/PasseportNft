//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Passeport is ERC721 {

    // enum ? hlhlkjkjhkjh

    // struct
    struct Worker {
        address workerAddress;
        string pseudo;
        uint256 age;
        string country;
        string language;
        string skills;
    }

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // mapping of people is register
    mapping(uint256 => address) private _register;

    // mapping of the register balance
    mapping(address => uint256) private _balances;

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
        _name =  name_;
        _symbol = symbol_;
    }

    // function

    function registerWorker (string memory countri, uint256 age, ) public {
        require (msg.sender != _register, "registerWorker : you are register");
        msg.sender += _register;


    }

    function registerPro () public {
        require (msg.sender != _register, "registerWorker : you are register");
        msg.sender += _register;

    }


    //function view

    function balanceOf (address user) public view returns (uint256){
        require(user == _register, "balanceOf :you are not registred");
        require(owner != address(0), "balanceOf : balance query for the zero address");
    return _balance[_register];
    }
}
