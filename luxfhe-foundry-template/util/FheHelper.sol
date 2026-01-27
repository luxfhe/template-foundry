// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {
    Euint8,
    Euint16,
    Euint32,
    Euint64,
    Euint128,
    inEuint256,
    Eaddress,
    Ebool
} from '@luxfhe/contracts/FHE.sol';

import { Test } from "forge-std/src/Test.sol";
import { MockFheOps } from "@luxfhe/contracts/utils/debug/MockFheOps.sol";

contract FheEnabled is Test {
    function initializeFhe() public {
        MockFheOps fheos = new MockFheOps();
        bytes memory code = address(fheos).code;
        vm.etch(address(128), code);
    }

    function unseal(address, string memory value) public pure returns (uint256) {
        bytes memory bytesValue = bytes(value);
        require(bytesValue.length == 32, "Invalid input length");

        uint256 result;
        assembly {
            result := mload(add(bytesValue, 32))
        }

        return result;
    }

    function encrypt8(uint256 value) public pure returns (Euint8 memory) {
        return Euint8(uint256ToBytes(value), 0);
    }

    function encrypt16(uint256 value) public pure returns (Euint16 memory) {
        return Euint16(uint256ToBytes(value), 0);
    }

    function encrypt32(uint256 value) public pure returns (Euint32 memory) {
        return Euint32(uint256ToBytes(value), 0);
    }

    function encrypt64(uint256 value) public pure returns (Euint64 memory) {
        return Euint64(uint256ToBytes(value), 0);
    }

    function encrypt128(uint256 value) public pure returns (Euint128 memory) {
        return Euint128(uint256ToBytes(value), 0);
    }

    function encrypt256(uint256 value) public pure returns (inEuint256 memory) {
        return inEuint256(uint256ToBytes(value), 0);
    }

    function encryptAddress(uint256 value) public pure returns (Eaddress memory) {
        return Eaddress(uint256ToBytes(value), 0);
    }

    function encryptBool(uint256 value) public pure returns (Ebool memory) {
        return Ebool(uint256ToBytes(value), 0);
    }

    function uint256ToBytes(uint256 value) private pure returns (bytes memory) {
        bytes memory result = new bytes(32);

        assembly {
            mstore(add(result, 32), value)
        }

        return result;
    }

}
