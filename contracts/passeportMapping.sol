//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Passeport is ERC721 {

    // using address from openzeppelin
    using Address for address payable;

        // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // worker
    mapping(address => string) private _pseudo;
    mapping(address => uint256) private _age;
    mapping(address => string) private _country;
    mapping(address => string) private _lang;
    mapping(address => string) private _skills;

    // mapping of worker is register
    mapping(address => bool) private _worker;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;

    event RegisterdWorker(address indexed addr, string pseudo, uint256 age, string country, string lang , string skills );
    event RegisterdPro(address indexed , string pseudo);
    event ModifiedWorker(address indexed addr, string pseudo, uint256 age, string country, string lang , string skills );

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // function

    function registerWorker(string memory pseudo_ , uint256 age_ , string memory country_, string memory lang_, string memory skills_) public {
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _lang[msg.sender] = lang_;
        _skills[msg.sender] = skills_;
        _worker[msg.sender] = true;

        emit RegisterdWorker(msg.sender , _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _lang[msg.sender], _skills[msg.sender]);
    }

    function registerPro(string memory pseudo_) public {
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        _pro[msg.sender] = true;
        _pseudo[msg.sender] = pseudo_;

        emit RegisterdPro(msg.sender, _pseudo[msg.sender]);

    }

    function modifyProfile(string memory pseudo_ , uint256 age_ , string memory country_, string memory lang_, string memory skills_) public {
        require(_worker[msg.sender] == true, "PasseportNFT: only worker can use this function");
        require(_pro[msg.sender] == false, "PasseportNFT: only worker can use this function");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _lang[msg.sender] = lang_;
        _skills[msg.sender] = skills_;

        emit ModifiedWorker(msg.sender , _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _lang[msg.sender], _skills[msg.sender]);
    }
    // TODO : worker defini son prix


    // TODO : pro paie le worker

/*
    function payWorker() public {
        require(_worker[msg.sender] == false, "PasseportNFT: only pro can use this function");
        require(_pro[msg.sender] == true, "PasseportNFT: only pro can use this function");
    }
*/
    //function view 
    //TODO : balanceOf a modifier

    function balancesOf(address user_) public view returns (uint256) {
        require(_worker[user_] == true, "PasseportNFT: you are not registred");
        require(user_ != address(0), "PasseportNFT: balance query for the zero address");
        return _balances[user_];
    }

    //TODO faire les fonction view pour chacuns des states du worker

    function getPseudo (address user_) public view returns (string memory) {
        return _pseudo[user_];
    }
    function getAge (address user_) public view returns (uint256) {
        return _age[user_];
    }
    function getCountry (address user_) public view returns (string memory) {
        return _country[user_];
    }

    function getLang (address user_) public view returns (string memory) {
        return _lang[user_];
    }

    function getSkills (address user_) public view returns (string memory) {
        return _skills[user_];
    }
// optinnal to check status
    function getStatus (address user_) public view returns (uint256) {
        uint256 status = 0;
        if(_worker[user_] == true) return 1;
        if(_pro[user_] == true) return 2;
        return status ;
    }

}
