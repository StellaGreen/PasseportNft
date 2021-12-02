//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Passeport is ERC721, ERC721Enumerable, ERC721URIStorage, AccessControl {

    // using address from openzeppelin
    using Address for address payable;
    using Counters for Counters.Counter;
    using Strings for uint256;

        // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // worker
    struct WorkerP {
        string pseudo;
        uint256 age;
        string country;
        string lang;
        string skills;
    }


    // mapping of worker is register
    mapping(address => bool) private _worker;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _pnpIds;
    mapping(uint256 => WorkerP) private _workp;

    event RegisterdPro(address indexed , string pseudo);
    event ModifiedWorker(address indexed addr, string pseudo, uint256 age, string country, string lang , string skills );

    // constructor
    constructor() ERC721("PasseportNFTpro", "PNP") {
        _setupRole(MINTER_ROLE, msg.sender);
    }

    // function

    function registerWorker(string memory pseudo , uint256 age, string memory country, string memory lang, string memory skills) public onlyRole(MINTER_ROLE) returns (uint256){
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
        _pnpIds.increment();
        uint256 currentId = _pnpIds.current();
        _mint(msg.sender, currentId);
        _setTokenURI(currentId, currentId.toString());
        _workp[currentId] = WorkerP(pseudo, age, country, lang, skills);
        _worker[msg.sender] = true;
        return currentId;

    }

    function registerPro(string memory pseudo) public {
        require(_pro[msg.sender] == false, "PasseportNFT: you are already registered as pro");
        require(_worker[msg.sender] == false, "PasseportNFT: you are already registered as worker");
        _pro[msg.sender] = true;

        emit RegisterdPro(msg.sender, pseudo);

    }


     function getPasseportById(uint256 id) public view returns (WorkerP memory) {
        return _workp[id];
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721URIStorage, ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }


     function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )  internal virtual override(ERC721Enumerable, ERC721) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

   function _burn(uint256 tokenId) internal virtual override(ERC721URIStorage, ERC721) {
        super._burn(tokenId);
    }
    
}
