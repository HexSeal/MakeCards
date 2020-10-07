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

    
}