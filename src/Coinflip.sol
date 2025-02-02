// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

error SeedTooShort();

/// @title Coinflip 10 in a Row
/// @author Tianchan Dong
/// @notice Contract used as part of the course Solidity and Smart Contract development
contract Coinflip is Ownable {
    
    string public seed;

    constructor() Ownable(msg.sender) {
        seed = "It is a good practice to rotate seeds often in gambling";
    }

    /// @notice Checks user input against contract generated guesses
    /// @param Guesses is a fixed array of 10 elements which holds the user's guesses. The guesses are either 1 or 0 for heads or tails
    /// @return true if user correctly guesses each flip correctly or false otherwise
    function userInput(uint8[10] calldata Guesses) external view returns (bool) {
        uint8[10] memory generatedFlips = getFlips(); //Get the contract generated flips by calling the helper function getFlips()

        // Compare each element of the user's guesses with the generated guesses. Return true ONLY if all guesses match
        for (uint8 i = 0; i < 10; i++) {
            if (Guesses[i] != generatedFlips[i]) {
                return false;
            }
        }
        return true;
    }

    /// @notice allows the owner of the contract to change the seed to a new one
    /// @param NewSeed is a string which represents the new seed
    function seedRotation(string memory NewSeed) public onlyOwner {
        bytes memory stringInBytes = bytes(NewSeed); //Cast the string into a bytes array so we may perform operations on it

        uint seedlength = stringInBytes.length; //Get the length of the array (ie. how many characters in this string)

        // Check if the seed is less than 10 characters (This function is given to you)
        if (seedlength < 10) {
            revert SeedTooShort();
        }
        
        seed = NewSeed; //Set the seed variable as the NewSeed
    }

    // -------------------- helper functions -------------------- //
    
    /// @notice This function generates 10 random flips by hashing characters of the seed
    /// @return a fixed 10 element array of type uint8 with only 1 or 0 as its elements
    function getFlips() public view returns (uint8[10] memory) {
        //Cast the seed into a bytes array and get its length
        bytes memory stringInBytes = bytes(seed);
        uint seedlength = stringInBytes.length;

        //Initialize an empty fixed array with 10 uint8 elements
        uint8[10] memory results;

        // Setting the interval for grabbing characters
        uint interval = seedlength / 10;

        //Input the correct form for the for loop
        for (uint i = 0; i < 10; i++) {
            // Generating a pseudo-random number by hashing together the character and the block timestamp
            uint randomNum = uint(keccak256(abi.encode(stringInBytes[i * interval], block.timestamp)));

            //if the result is an even unsigned integer, record it as 1 in the results array, otherwise record it as zero
            results[i] = (randomNum % 2 == 0) ? 1 : 0;
        }

        //return the resulting fixed array
        return results;
    }
}
