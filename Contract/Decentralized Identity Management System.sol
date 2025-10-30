// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedIdentityManagementSystem {
    struct Identity {
        string name;
        string email;
        bool isRegistered;
    }

    mapping(address => Identity) private identities;

    event IdentityRegistered(address indexed user, string name, string email);
    event IdentityUpdated(address indexed user, string name, string email);

    // Register a new identity
    function registerIdentity(string memory _name, string memory _email) public {
        require(!identities[msg.sender].isRegistered, "Identity already registered");
        identities[msg.sender] = Identity(_name, _email, true);
        emit IdentityRegistered(msg.sender, _name, _email);
    }

    // Update existing identity
    function updateIdentity(string memory _name, string memory _email) public {
        require(identities[msg.sender].isRegistered, "Identity not registered");
        identities[msg.sender].name = _name;
        identities[msg.sender].email = _email;
        emit IdentityUpdated(msg.sender, _name, _email);
    }

    // Retrieve identity details
    function getIdentity(address _user) public view returns (string memory name, string memory email, bool isRegistered) {
        Identity memory id = identities[_user];
        return (id.name, id.email, id.isRegistered);
    }
}
