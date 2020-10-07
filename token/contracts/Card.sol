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

    event Transfer(address _from, address _to, card senderCard); // Card Trade event

    event Trade(address _from, address _to, card senderCard, card receiverCard); // Card Trade event

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

    function getTotalNumOfCards(address _addr) public view returns(uint) { 
        //Returns the total number of cards that are associated with the address
        return balances[_addr];
    } 
}