<template>
  <h1>Supply Chain</h1>
  <h2>Items</h2>
  <div class="add-item">
    <label>Price:</label>
    <input type="text" v-model="itemPrice" />
    <label>Name:</label>
    <input type="text" v-model="itemName" />
    <button @click="handleAddItem">Add Item</button>
  </div>
</template>

<script>
import ItemManagerContract from "./contracts/ItemManager.sol/ItemManager.json";
// import ItemContract from "./contracts/Item.sol/Item.json";
import addresses from "./.env/contract-addresses.json";
import { ethers } from "ethers";

export default {
  name: "App",
  components: {},
  data() {
    return {
      itemManager: undefined,
      itemPrice: 0,
      itemName: "",
    };
  },
  mounted() {
    const provider = new ethers.providers.WebSocketProvider(
      "ws://localhost:8545"
    );
    const signer = provider.getSigner();
    const itemManager = new ethers.Contract(
      addresses.ItemManager,
      ItemManagerContract.abi,
      signer
    );
    itemManager.on("CheckState", (index, state, address) => {
      console.log(index, state, address);
    });
    this.itemManager = itemManager;
  },
  methods: {
    handleAddItem: async function () {
      const transaction = await this.itemManager.createItem(
        this.itemName,
        this.itemPrice
      );
      const receipt = await transaction.wait();
      console.log(receipt.events[0].address);
    },
  },
};
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.add-item {
  label {
    margin-right: 2px;
  }
  input {
    margin-right: 15px;
  }
}
</style>
