// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AstroTroveCheckin {
    struct CheckInRecord {
        uint256 checkInCount;
        uint256 lastCheckInTime;
    }
    mapping(address => CheckInRecord) public checkInRecords;

    event CheckIn(
        address indexed user,
        uint256 checkInCount,
        uint256 timestamp
    );

    function checkIn() external {
        CheckInRecord storage record = checkInRecords[msg.sender];

        record.checkInCount += 1;
        record.lastCheckInTime = block.timestamp;

        emit CheckIn(msg.sender, record.checkInCount, block.timestamp);
    }

    function getCheckInRecord(address user)
        external
        view
        returns (uint256 checkInCount, uint256 lastCheckInTime)
    {
        CheckInRecord memory record = checkInRecords[user];
        return (record.checkInCount, record.lastCheckInTime);
    }
}
