pragma solidity ^0.4.17;

/*
We start the contract off with 3 imports
*/
import "truffle/Assert.sol"; // Gives us various assertions to use in our tests
import "truffle/DeployedAddresses.sol"; // This smart contract gets the address of the deployed contract.
import "../contracts/Adoption.sol"; // The smart contract we want to test.

/*
Then we define a contract-wide variable containing the smart 
contract to be tested, calling the DeployedAddresses smart 
contract to get its address.
*/

contract TestAdoption {
    Adoption adoption = Adoption(DeployedAddresses.Adoption());
    /*
    To test the adopt() function, recall that upon success 
    it returns the given petId. We can ensure an ID was 
    returned and that it's correct by comparing the 
    return value of adopt() to the ID we passed in.
    */
    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(8);

        uint expected = 8;
        /*
        We call the smart contract we declared earlier with the ID of 8.
        We then declare an expected value of 8 as well.
        Finally, we pass the actual value, the expected value and a 
        failure message (which gets printed to the console if the test 
        does not pass) to Assert.equal().
        */
        Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recorded.");
    }
    /*
    Remembering from above that public variables have automatic 
    getter methods, we can retrieve the address stored by our 
    adoption test above. Stored data will persist for the duration 
    of our tests, so our adoption of pet 8 above can be retrieved 
    by other tests.
    */
    function testGetAdopterAddressByPetId() public {

        address expected = this;
        address adopter = adoption.adopters(8);

        Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
    }

    // Testing retrieval of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        // Expected owner is this contract
        address expected = this;

        // Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();
        /*
        Note the memory attribute on adopters. 
        The memory attribute tells Solidity to temporarily 
        store the value in memory, rather than saving it to 
        the contract's storage. Since adopters is an array, 
        and we know from the first adoption test that we 
        adopted pet 8, we compare the testing contracts 
        address with location 8 in the array.
        */

        Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
    }
}

 