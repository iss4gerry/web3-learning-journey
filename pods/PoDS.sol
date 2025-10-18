// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PoDS {
    uint nextId = 0;
    struct Activity{
        bytes32 name;
        address owner;
        address[] participants;
    }

    mapping (uint => Activity) public activities;
    mapping (address => uint[]) public userActivities;
    mapping (address => mapping(uint => bool)) public hasDoneActivity;

    event ActivityAdded(uint id, address owner);
    event ActivityDone(uint id, address participant);

    function stringToBytes (string memory source) public pure returns (bytes32 result){
        require(bytes(source).length <= 32, "Source string too long");
        assembly{
            result := mload(add(source,32))
        }
    }


    function addActivity(string memory _name) public {
        uint id = nextId++;
        activities[id] = (Activity({
            name: stringToBytes(_name),
            owner: msg.sender,
            participants: new address[](0)
        }));

        emit ActivityAdded(id, msg.sender);
    }

    function doingActivity (uint _id) public {
        require(activities[_id].owner != address(0), "Activity does not exist");
        require(!hasDoneActivity[msg.sender][_id], "User has already done this activity");
        activities[_id].participants.push(msg.sender);
        userActivities[msg.sender].push(_id);
        hasDoneActivity[msg.sender][_id] = true;

        emit ActivityDone(_id, msg.sender);
    }

    function getParticipants (uint _id) public view returns(address[] memory){
        return activities[_id].participants;
    }

    function getTotalParticipants (uint _id) public view returns(uint) {
        return activities[_id].participants.length;
    }

}
