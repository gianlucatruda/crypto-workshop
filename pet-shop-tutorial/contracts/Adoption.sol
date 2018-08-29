/*
The minimum version of Solidity required is 
noted at the top of the contract.

The pragma command means "additional information 
that only the compiler cares about", 
while the caret symbol (^) means 
"the version indicated or higher".
*/
pragma solidity ^0.4.17;

contract Adoption {

    /*
    We've defined a single variable: adopters. 
    This is an array of Ethereum addresses. 
    Arrays contain one type and can have a fixed 
    or variable length. In this case the type is 
    address and the length is 16.
    Public variables have automatic getter methods, 
    but in the case of arrays a key is required 
    and will only return a single value.
    */
    address[16] public adopters;

    /*
    In Solidity the types of both the function parameters 
    and output must be specified.
    */
    function adopt(uint petId) public returns (uint) {
        /*
        We are checking to make sure petId is in range of 
        our adopters array. Arrays in Solidity are indexed 
        from 0, so the ID value will need to be between 0 and 15. 
        We use the require() statement to ensure the ID is within range.
        */
        require(petId >= 0 && petId <= 15, "Error");
        /*
        If the ID is in range, we then add the address 
        that made the call to our adopters array. 
        The address of the person or smart contract 
        who called this function is denoted by msg.sender.
        */
        adopters[petId] = msg.sender;
        /*
        Finally, we return the petId provided as a confirmation.
        */
        return petId;
    }
    /*
    Since adopters is already declared, we can simply return it. 
    Be sure to specify the return type (in this case, 
    the type for adopters) as address[16].
    */
    function getAdopters() public view returns (address[16]) {
        return adopters;
    }
}

