pragma solidity ^0.5.16;

contract RandomNumberGenerator{

uint256 private nonce;

	constructor () public {
	       nonce = 1;
	}

    /**
    * @dev Generates a random number
    */
    function generateRandomNumber(uint256 maxValue) private view returns(uint256) {
        return uint256(keccak256(abi.encodePacked(now, block.timestamp, block.difficulty, nonce))) % maxValue;
    } 
}