// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ItemManager.sol";

enum State { Created, Paid, Delivered }

contract Item {
  ItemManager manager;
  uint public index;
  string public identifier;
  uint public price;
  State public state;

  constructor(ItemManager _manager, uint _index, string memory _identifier, uint _price, State _state) {
    manager = _manager;
    index = _index;
    identifier = _identifier;
    price = _price;
    state = _state;
  }
  function setState(State _state) public {
    state = _state;
  }
  receive() external payable {
    require(price == msg.value, "Only full payments accepted");
    require(state == State.Created, "Item further in the chain");
    (bool success, ) = address(manager).call{ value: msg.value }(abi.encodeWithSignature("triggerPayment(uint256)", index));
    require(success, "Transaction rejected");
  }
}
