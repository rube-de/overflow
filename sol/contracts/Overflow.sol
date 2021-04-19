pragma solidity 0.5.12;

import "./SafeMath.sol";

contract Overflow{

    mapping (address=>uint) balances;

    function contribute() public payable{
        balances[msg.sender] = msg.value;
    }

    function getBalance() public view returns (uint){
        return balances[msg.sender];
    }

    function batchSend(address[] memory _receivers, uint _value) public {
        // this line overflows
        uint total = SafeMath.mul(_receivers.length, _value);
        require(balances[msg.sender]>=total);

        // subtract from sender
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], total);

        for(uint i=0;i<_receivers.length;i++){
            balances[_receivers[i]] = SafeMath.add(balances[_receivers[i]], _value);
        }
    }
}