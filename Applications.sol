// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
import "./SafeMath.sol";

contract Applications {
    using SafeMath for uint256;
    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
    function supDivide(uint a, uint b, uint precision) internal pure returns ( uint) {
        //return a*(10**precision)/b;
        return (a.mul(10**precision)).div(b);
    }
    function getImageType(uint _count) internal pure returns (string memory) {
        string memory imageToken;
        if (_count < 10) imageToken="https://es.theepochtimes.com/assets/uploads/2019/05/gold-nugget-2269846_1920-795x447.jpg";
        if (_count >=10 && _count <=100) imageToken="https://mygoldnugget.com/wp-content/uploads/2020/11/10-pepitas-4.jpg";
        if (_count>100) imageToken="https://ichef.bbci.co.uk/news/800/cpsprodpb/9971/production/_105418293_4b4fef50-4b2c-42fd-9361-01af10b7d6a4.jpg.webp";
        return imageToken;
    }
    function isEntireCollection(uint256 _input, uint256 _output) internal pure returns (string memory) {
        string memory _isEntire;
        _input==_output ? _isEntire = "TRUE" : _isEntire = "FALSE";
        return _isEntire; 
    }
   function convertoToNativeToken(uint256 _amount, uint256 _tokenPrice) internal pure returns (uint256) {
       return supDivide(_amount, _tokenPrice, 0);
   }
   function attributeForTypeAndValue(string memory traitType, string memory value) internal pure returns (string memory) {
    return string(abi.encodePacked(
      '{"trait_type":"',
      traitType,
      '","value":"',
      value,
      '"}'
    ));
  }
  string internal constant TABLE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  function base64(bytes memory data) internal pure returns (string memory) {
    if (data.length == 0) return '';
    
    // load the table into memory
    string memory table = TABLE;

    // multiply by 4/3 rounded up
    uint256 encodedLen = 4 * ((data.length + 2) / 3);

    // add some extra buffer at the end required for the writing
    string memory result = new string(encodedLen + 32);

    assembly {
      // set the actual output length
      mstore(result, encodedLen)
      
      // prepare the lookup table
      let tablePtr := add(table, 1)
      
      // input ptr
      let dataPtr := data
      let endPtr := add(dataPtr, mload(data))
      
      // result ptr, jump over length
      let resultPtr := add(result, 32)
      
      // run over the input, 3 bytes at a time
      for {} lt(dataPtr, endPtr) {}
      {
          dataPtr := add(dataPtr, 3)
          
          // read 3 bytes
          let input := mload(dataPtr)
          
          // write 4 characters
          mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr(18, input), 0x3F)))))
          resultPtr := add(resultPtr, 1)
          mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr(12, input), 0x3F)))))
          resultPtr := add(resultPtr, 1)
          mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr( 6, input), 0x3F)))))
          resultPtr := add(resultPtr, 1)
          mstore(resultPtr, shl(248, mload(add(tablePtr, and(        input,  0x3F)))))
          resultPtr := add(resultPtr, 1)
      }
      
      // padding with '='
      switch mod(mload(data), 3)
      case 1 { mstore(sub(resultPtr, 2), shl(240, 0x3d3d)) }
      case 2 { mstore(sub(resultPtr, 1), shl(248, 0x3d)) }
    }
    
    return result;
  }
}