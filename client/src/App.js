import ItemManagerContract from "./contracts/ItemManager.sol/ItemManager.json";
// import ItemContract from "./contracts/Item.sol/Item.json";
import addresses from "./.env/contract-addresses.json";
import { useEffect, useState } from "react";
import { ethers } from "ethers";

import './App.css';

function App() {
  const [itemManagerContract, setItemManagerContract] = useState();
  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider();
    const signer = provider.getSigner();
    setItemManagerContract(new ethers.Contract(
      addresses.ItemManager,
      ItemManagerContract.abi,
      signer
    ));
  }, []);
  const addItem = async () => {
    const transaction = await itemManagerContract.createItem("item1", 1000);
    await transaction.wait();
  }
  const checkItem = async () => {
    console.log(await itemManagerContract.items(0));
  }
  return (
    <div className="App">
      <h1>Supply Chain</h1>
      <h2>Items</h2>
      <button onClick={ addItem }>Add Item</button>
      <button onClick={ checkItem }>Check Item</button>
    </div>
  );
}

export default App;
