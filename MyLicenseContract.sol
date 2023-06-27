// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Import required contracts and libraries from OpenZeppelin
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// This contract inherits from the ERC1155 token standard and includes functionality to mint licenses as NFTs
contract MyLicenseContract is ERC1155, Ownable {
    
    // Counter used to manage token IDs
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Cost of a license and the duration of the license
    uint256 public licensePrice = 0.0042 ether;
    uint256 public licenseDuration = 365 days;

    // 2 partners will share the license payment
    address public partner1 = PARTNER1_ADDRESS;
    address public partner2 = PARTNER2_ADDRESS;
    
    // Maps token IDs to their expiration dates and owners to their tokens
    mapping(uint256 => uint256) public licenseExpiry;
    mapping(address => uint256[]) public licenseHolders;

    constructor() ERC1155("") {}

    // Mint a new license
    function mint() public payable {
        require(msg.value == licensePrice, "Payment must be 0.0042 ether");

        _tokenIds.increment();
        uint256 newLicenseId = _tokenIds.current();

        _mint(msg.sender, newLicenseId, 1, "");
        licenseExpiry[newLicenseId] = block.timestamp + licenseDuration;
        licenseHolders[msg.sender].push(newLicenseId);

        // Send partners the payment
        payable(partner1).transfer(msg.value / 2 );
        payable(partner2).transfer(msg.value / 2 );
    }

    // Returns the URI for all tokens in this contract
    function uri(uint256) override public pure returns (string memory) {
        return string(abi.encodePacked("https://ipfs.io/ipfs/METADATA_CID"));
    }

    // Check if the given account is the owner of the given token ID
    function checkLicense(address _owner, uint256 _tokenId) public view returns (bool) {
        uint256[] memory holderTokens = licenseHolders[_owner];
        for (uint256 i = 0; i < holderTokens.length; i++) {
            if (holderTokens[i] == _tokenId) {
                return true;
            }
        }
        return false;
    }

    // Return all token IDs owned by a given account
    function printLicenseBalances(address _owner) public view returns (uint256[] memory) {
        return licenseHolders[_owner];
    }

    // Return the remaining time as days
    function remainingDays(uint256 _tokenId) public view returns (uint256) {
        if (licenseExpiry[_tokenId] > block.timestamp) {
            return (licenseExpiry[_tokenId] - block.timestamp) / 1 days;
        } else {
            return 0;
        }
    }
}
