// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

interface OracleInterface {
    function getPrice() external view returns(uint);
    function getLastUpdate() external view returns(uint);
}

interface MaintenancePrice {
    function calculateMaintenance(uint,uint) external view returns(uint[] calldata);
}

interface GoldData {
    function goldWeight(uint) external view returns(uint);
    function goldPurity(uint) external view returns(uint);
}