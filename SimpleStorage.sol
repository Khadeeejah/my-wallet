// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SimpleStorage {

    address owner;

    // modifier onlyOwner(){
    //     require(msg.sender == owner, "Only owner can call this function");
    //     _;
    // }

    modifier addOnlyOnce(address _addr){
        require(!usersAdded[_addr], "Sorry, you have already added");
        _;
    }


    constructor(){
        owner = msg.sender;
    }

    struct User{
        string name;
        uint256 age;
        string country;
    }

    mapping(address => User) public users;
    mapping(address => bool) public usersAdded;

    function add(string memory _name, uint256 _age, string memory _country) external addOnlyOnce(msg.sender){
        // tx.origin
        User memory _user = User(_name, _age, _country);
        users[msg.sender] = _user;
        usersAdded[msg.sender] = true;
    }

    function update(string memory _name, uint256 _age, string memory _country) external {
        User storage _user = users[msg.sender];
        _user.name = _name;
        _user.age = _age;
        _user.country = _country;
    }
}