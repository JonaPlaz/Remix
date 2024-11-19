// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Alyra is ERC721A, Ownable {

    uint256 private constant MAX_SUPPLY = 30;
    uint256 private constant PRICE_PER_NFT = 0.000002 ether;
    uint256 private constant AMOUNT_NFT_PER_WALLET = 2;

    string public baseURI;

    using Strings for uint;

    mapping(address => uint256) amountNftMintedPerWallet;

    constructor(string memory _baseURI) ERC721A("Alyra", "ALY") Ownable(msg.sender) {
        baseURI = _baseURI;
    }

    function mint(uint256 _quantity) external payable {
        // On va contrôler que une adresse n'a pas acheté plus de AMOUNT_NFT_PER_WALLET NFTs
        require(amountNftMintedPerWallet[msg.sender] + _quantity <= AMOUNT_NFT_PER_WALLET, "Can only mint 2 NFTs");
        // On va contrôler que en tout, les utilisateurs ne mintent pas + de MAX_SUPPLY NFTs
        require(totalSupply() + _quantity <= MAX_SUPPLY, "Max supply exceeded");
        // On  va contrôler que l'utilisateur donne assez d'argent
        require(msg.value >= PRICE_PER_NFT * _quantity, "Not enough funds");
        amountNftMintedPerWallet[msg.sender] += _quantity;
        _mint(msg.sender, _quantity);
    }

    function setBaseURI(string memory _baseURI) external onlyOwner {
        baseURI = _baseURI;
    }

    // 
    // https://fdsfds.aws.com/macollectionNFT/
    // ipfs://CID/999.json
    function tokenURI(uint _tokenId) public view virtual override(ERC721A) returns(string memory) {
        require(_exists(_tokenId), "URI query for nonexistent token");
        return string(abi.encodePacked(baseURI, _tokenId.toString(), ".json"));

        // ipfs://CID/7.json
        // https://fdqf.aws.com/macollectionNFT/7.json
    }
}