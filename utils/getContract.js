import ContractAbi from "../artifacts/contracts/Cosecha.sol/Cosecha.json";
import { ethers } from "ethers";

export default function getContract() {
  // Creating a new provider
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  // Getting the signer
  const signer = provider.getSigner();
  // Creating a new contract factory with the signer, address and ABI
  let contract = new ethers.Contract(
    "0x52A13eF30Da4a73aAB8CB1d033C37dB201ea014c",
    ContractAbi.abi,
    signer
  );
  // Returning the contract
  return contract;
}
