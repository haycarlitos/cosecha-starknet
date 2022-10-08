//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Cosecha {
    // Declaring the licenseCount 0 by default
    uint256 public licenseCount = 0;
    // Name of your contract
    string public name = "Cosecha";

    mapping(uint256 => License) public licenses;

    //  Create a struct called 'License' with the following properties:
    struct License {
        uint256 id;
        string thumbnailHash;
        string location;
        string category;
        string date;
        address author;
    }

    // Create a 'LicenseUploaded' event that emits the properties of the license
    event LicenseUploaded(
        uint256 id,
        string thumbnailhash,
        string location,
        string category,
        string date,
        address author
    );

    constructor() {}

    // Function to upload a license
    function uploadLicense(
        string memory _thumbnailHash,
        string memory _location,
        string memory _category,
        string memory _date
    ) public {
        // Validating the thumbnailHash and author's address
        require(bytes(_thumbnailHash).length > 0);
        require(msg.sender != address(0));

        // Incrementing the license count
        licenseCount++;
        // Adding the license to the contract
        licenses[licenseCount] = License(
            licenseCount,
            _thumbnailHash,
            _location,
            _category,
            _date,
            msg.sender
        );
        // Triggering the event
        emit LicenseUploaded(
            licenseCount,
            _thumbnailHash,
            _location,
            _category,
            _date,
            msg.sender
        );
    }
}
