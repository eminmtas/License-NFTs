# License-NFTs

This repo contains a Solidity smart contract that implements functionality for minting and managing licenses as non-fungible tokens (NFTs). The contract is based on the `ERC-1155` token standard.

## Features

1. **Minting Licenses:** Users can mint new licenses by paying 0.0042 ether. This payment is evenly split between two specified partner addresses. Each license is represented as a unique `ERC-1155` token.

2. **License Duration and Expiry:** Each license is valid for a specific duration from the time of minting. The contract includes a mapping from token IDs to their expiry timestamps, allowing for easy verification of whether a license is still valid or not.

3. **License Ownership:** The contract keeps track of the licenses owned by each account, allowing for quick retrieval of the license IDs associated with an address.

4. **License Verification:** The contract provides functions to check if a particular account is the owner of a specific license. It also includes a function to determine the remaining days of validity for a license.

5. **IPFS Metadata:** The contract includes a function that returns a hardcoded IPFS URI for all tokens.

## Getting Started

To interact with this contract using the Remix IDE:

1. Deploy your NFT image to IPFS and copy the CID of it.
2. Paste the CID to `metadata.json` file and customize the metadata file.
3. Deploy the `metadata.json` file to IPFS and save the CID of it to use it in the smart contract.
4. Go to [Remix](https://remix.ethereum.org/).
5. Click on the file icon from the left panel to open up the file explorer.
6. Then click on the "New File" icon to create a new file and name it `"MyLicenseContract.sol"`.
7. Copy and paste the Solidity code into this new file.
8. Paste the `metadata.json` file's CID to the `uri` function.
9. You can customize some part of the contract. e.g. `licensePrice, licenseDuration, partner1 and partner2`
10. Make sure the compiler version in the Remix IDE matches the version specified in the contract (0.8.4).
11. Compile the contract by clicking on the "Solidity Compiler" button or press Ctrl + S.
12. Deploy the contract by going to the "Deploy & Run Transactions" section, choose the appropriate environment and click the "Deploy" button.
13. You can now interact with the contract with using the buttons that have appeared in the "Deployed Contracts" section.
14. Additionally you can deploy to the Goerli Test Network and test it with better interface. 

## Dependencies

This contract uses OpenZeppelin's contracts and libraries for secure and reliable development.

1. `@openzeppelin/contracts/token/ERC1155/ERC1155.sol`: For the basic functionality of the ERC-1155 token standard.
2. `@openzeppelin/contracts/utils/Counters.sol`: For managing token IDs.
3. `@openzeppelin/contracts/access/Ownable.sol`: For owner-only functionality.
4. `@openzeppelin/contracts/utils/Strings.sol`: For string conversion.

## Notes

This contract is intended for educational purposes and should not be used in production without further testing and security measures.
