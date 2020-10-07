pragma solidity ^0.6.0;

import "./SafeMath.sol";

// A contract for cards!!
contract MakeCard {
    // Card Name
    string public name = 'MakeCard';
    
    // The abbreviation for cards
    string public symbol = 'mc';

    struct card {
        string name;
    }

    // key-value pairs to keep track of user's card collection data
    mapping (address => uint) balances;

    mapping (address => []card) allCards;
    
    mapping (unit256 => card) IDtoCardMap;

    event Transfer(address _from, address _to, uint256 _value, card senderCard); // Card Trade event

    event Trade(address _from, address _to, uint256 _value, card senderCard, card recieverCard); // Card Trade event

    //  Called automatically when the contract is created
    constructor() public {
        // everyone starts with 0 cards
        balances[msg.sender] = 0
    }

    // function checks if the address owns the card
    function checkIfOwns(uint256 cardID, address addr) public returns(bool sufficient) {
        for (uint i = 0; i < len(allCards[msg.sender]); i++) {
            if (allCards[addr][i] == cardID) {
                return true
            }
        }
        return false
    }
    
    function removeCard(uint256 cardID, address addr) public {
        for (uint i = 0; i < len(allCards[msg.sender]); i++) {
            if (allCards[addr][i] == cardID) {
                delete allCards[addr][i]
            }
        }
    }
    
    
}