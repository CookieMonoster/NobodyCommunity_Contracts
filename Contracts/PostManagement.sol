// SPDX-License-Identifier: MIT
pragma solidity >=0.8 <0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./PostStorage.sol";

contract PostManagement is PostStorage{
  
  using SafeMath for uint256;

  function _createNewPost (string calldata _title, string calldata _content) public{
    posts.push(Post(_title, _content, toAsciiString(msg.sender)));
    (, uint id) =  posts.length.trySub(1);
    postToOwner[id] = msg.sender;
    userPostCount[msg.sender] = userPostCount[msg.sender].add(1);
    emit NewPost(_title, _content, toAsciiString(msg.sender));
  }

  function _getPostsByUser(address _user) public view returns(uint[] memory){
    uint[] memory result = new uint[](userPostCount[_user]);
    uint counter = 0;
    for (uint i = 0; i < posts.length; i++) {
      if (postToOwner[i] == _user) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  function toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
        bytes1 hi = bytes1(uint8(b) / 16);
        bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
    return string(s);
  }

  function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
  }

}
