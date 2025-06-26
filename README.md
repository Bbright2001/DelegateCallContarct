<h1># Delegatecall vs Call – Solidity Classwork</h1>

This project demonstrates the difference between `call` and `delegatecall` in Solidity by deploying two contracts (`A` and `B`) with identical storage layouts and observing how storage is affected when calling functions across them.

<hr>

## 📦 Contracts

- **ContractA.sol**: The main contract that performs both `call` and `delegatecall`.
- **ContractB.sol**: Contains the `setVars(uint256)` logic to be called or delegate-called; also uses contract A storage.


<hr>

## 🚀 Deployment Details

- **Network**: Ethereum Sepolia testnet
- **Chain ID**: `11155111`  
- **Deployed via**: Foundry script with `--broadcast` enabled

<hr>

## 📌 Deployed Addresses

- **Contract A**: `0xde92aaa7e6f83f65d28e861db42b06bbf6360440`  
- **Contract B**: `0xb9435810d853a60dee2c9699e6f96564a0b89eab`


<hr>


## Screenshots of Storage before and after delegate call and call

![Test Image](images/storage.png)

<hr>

## Answers to Classwork Questions

###What differences did you observe between `call` and `delegatecall`?

- `call`: Executes the target contract’s code in **its own** context. Storage changes affect **Contract B**, and `msg.sender` becomes **Contract A**.
- `delegatecall`: Runs the target’s code in **the calling contract’s** context. Storage and `msg.sender` refer to **Contract A**.

<hr>
### Why must the storage layout in ContractA and ContractB be exactly the same when using `delegatecall`?

- `delegatecall` writes to the caller’s (Contract A's) storage.
- If layouts don’t match, data will be written to **wrong slots**, leading to corrupted state which can lead to reentracy from intruders.

<hr>

###Which method would you use for creating upgradeable contracts and why?

- ✅ **Use `delegatecall`**
- It separates **logic (Contract B)** from **storage (Contract A)**.
- Reusabibility and Upgradability.

<hr>

## 🧪 How to Run This Project

```bash
# 1. create a .env file

# 2. store yor RPC URL and private key in the .env

# 3. In the terminal, source your .env
 source .env

# 3. Run the deployment script
forge script script/Contract.s.sol --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast
