//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Passeport is ERC721 {
    // worker

    mapping(address => string) private _pseudo;
    mapping(address => uint256) private _age;
    mapping(address => string) private _country;
    mapping(address => string) private _lang;
    mapping(address => string) private _skills;

    // mapping of people is register

    mapping(address => bool) private _worker;

    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;

    event RegisterdWorker(address indexed);
    event RegisterdPro(address indexed);

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // function

    function registerWorker() public {
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
        _worker[msg.sender] = true;

        emit RegisterdWorker(msg.sender)
    }

    function registerPro() public {
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        _pro[msg.sender] = true;

        emit RegisterdPro(msg.sender)

    }

    function modifyProfile() public {
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
    }
    function payWorker() public {

    }

    //function view

    function balanceOf(address user) public view returns (uint256) {
        require(user == _register, "balanceOf :you are not registred");
        require(owner != address(0), "balanceOf : balance query for the zero address");
        return _balance[_register];
    }
}
