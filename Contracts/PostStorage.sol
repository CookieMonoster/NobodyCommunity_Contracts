// SPDX-License-Identifier: MIT
pragma solidity >=0.8 <0.9.0;

contract PostStorage{
  
  struct Post{
        string title;
        string content;
        string author;
    }

  event NewPost(string title, string content, string author);

  Post[] posts;
  
  mapping (uint => address) postToOwner;
  mapping (address => uint) userPostCount;

  function getPosts() public view returns(Post[] memory) {
        return posts;
  }

  function getPost(uint _index) public view returns(Post memory) {
        return posts[_index];
  }


}