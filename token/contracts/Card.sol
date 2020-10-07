pragma solidity ^0.6.0;

import "./SafeMath.sol";

// A contract for cards!!
contract MakeCard {
    // Card Name
    string public name = 'MakeCard';
    
    // The abbreviation for cards
    string public symbol = 'mc';

    struct Card {
        string name;
        uint256 id;
    }

    // key-value pairs to keep track of user's card collection data
    mapping (address => uint) balances;

    // key-value pairs to keep track of the user's cards they own
    mapping (address => []Card) allCards;
    
    // key-value pairs to keep track of the cards and the associated IDs
    mapping (unit256 => Card) IDtoCardMap;

    event Transfer(address _from, address _to, Card senderCard); // Card Trade event

    event Trade(address _from, address _to, Card senderCard, Card receiverCard); // Card Trade event

    //  Called automatically when the contract is created
    constructor() public {
        // everyone starts with 0 cards
        balances[msg.sender] = 0
    }

    // function checks if the address owns the card
    function checkIfOwns(uint256 cardID, address addr) public returns(bool sufficient) {
        // iterate through all the cards the user has
        for (uint i = 0; i < len(allCards[addr]); i++) {
            // if the card was found, return true
            if (allCards[addr][i] == cardID) {
                return true
            }
        }
        // if they do not have the card, return false
        return false
    }
    
    // removeCard removes a card from the users list of cards
    function removeCard(uint256 cardID, address addr) public {
        // iterate through the list of cards a user has
        for (uint i = 0; i < len(allCards[addr]); i++) {
            // if the card is found, delete it from the list
            if (allCards[addr][i] == cardID) {
                delete allCards[addr][i]
            }
        }
    }
    
    // Allows a user to give a card from their collection to another user
    function sendCard(address _receiver, address _sender, uint256 cardID) public returns(bool sufficient) {
        // validate transfer, make sure the sender owns the card they want to send
        require(checkIfOwns(cardID, _sender), "Must own a card to send it");

        // increment and decrement the sender and receivers card balance respectively
        balances[_sender].sub(1);
        balances[_receiver].add(1);

        // add card to receiver
        allCards[_receiver] += IDtoCardMap[cardID];
        // remove the card from the sender 
        removeCard(cardID, _sender);
        // complete card transfer and call event to record the log
        emit Transfer(_sender, _receiver, _amount, IDtoCardMap[cardID]);            
        return true;
    }
    
    // Creates a trade between two players, where each offer a card for another. (WIP: Trade confirmation, trading 1 card for multiple)
    function tradeCard(address _receiver, uint256 senderCardID, uint256 receiverCardID) public returns(bool sufficient) {
        // validate transfer, make sure the sender has enough cards to send
        require(checkIfOwns(senderCardID, msg.sender), "Sender must own a card to send it");
        require(checkIfOwns(receiverCardID, _receiver), "Receiver must own a card to send it");

        // send the cards to be traded to the sender and receiver
        sendCard(_receiver, msg.sender, senderCardID);
        sendCard(msg.sender, _receiver, receiverCardID);

        // emit the Trade event
        emit Trade(msg.sender, _receiver, IDtoCardMap[senderCardID], IDtoCardMap[receiverCardID]);            

        // complete card transfer and call event to record the log
        return true;
    }

    // getTotalNumOfCards returns the total number of cards the user has
    function getTotalNumOfCards(address _addr) public view returns(uint) { 
        //Returns the total number of cards that are associated with the address
        return balances[_addr];
    } 

    // makeCard makes a card of type Card
    function makeCard(string cardName, uint256 ID) public view returns(card) {
        // initialize card of type Card struct
        c = Card{
            id: ID,
            name: "cardName",
        }

        // add card to map
        IDtoCardMap[ID] = c

        // return card
        return c
    }
}