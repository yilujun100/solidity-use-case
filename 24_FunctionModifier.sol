// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FunctionModifier {
  address public owner;
  uint256 public x = 10;
  bool public locked;

  constructor() {
    owner = msg.sender;
  }

  // Modifier to check that the caller is the owner of the contract
  modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    // Underscore is a special character only used inside
    // a function modifier and it tells Solidity to
    // execute the rest of the code.
    _;
  }

  modifier validAddress(address _addr) {
    require(_addr != address(0), "Not valid address");
    _;
  }

  function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
    owner = _newOwner;
  }

  modifier noReentrancy() {
    require(!locked, "No reentrancy");

    locked = true;
    _;
    locked = false;
  }

  function decrement(uint256 i) public noReentrancy {
    x -= i;

    if (i > 1) {
      decrement(i - 1);
    }
  }
}