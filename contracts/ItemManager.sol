// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Item.sol";

contract ItemManager is Ownable {
  mapping(uint => Item) public items;
  uint index;

  event CheckState(uint _index, uint _state, address _adress);

  function createItem(string memory _identifier, uint _price) public onlyOwner {
    Item item = new Item(this, index, _identifier, _price, State.Created);
    items[index] = item;
    emit CheckState(index, uint(items[index].state()), address(items[index]));
    index++;
  }
  function triggerPayment(uint _index) public payable {
    items[_index].setState(State.Paid);
    emit CheckState(_index, uint(items[_index].state()), address(items[_index]));
  }
  function triggerDelivery(uint _index) public onlyOwner {
    require(items[_index].state() == State.Paid, "Item is not paid");
    items[_index].setState(State.Delivered);
    emit CheckState(_index, uint(items[_index].state()), address(items[_index]));
  }
}
