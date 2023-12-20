
# Libraries 
This folder contains the external and custom libraries that are used to enhance the functionality, efficiency, and reusability of the smart contracts in this project . 
We used these libraries to handle arithmetic calculations and perform mathematical operations securely within smart contracts :

- `SafeMath.sol`:  SafeMath is one of the most popular math libraries in Solidity. It is designed to prevent integer overflow and underflow vulnerabilities, which are common security risks in smart contracts. The library provides safe arithmetic functions like addition, subtraction, multiplication, and division, ensuring that the results stay within the acceptable range.
- `Math.sol`: The Math library in Solidity provides basic mathematical functions like finding the maximum or minimum of two numbers, computing the absolute value of an integer, and raising numbers to specific powers.

![](https://img.shields.io/badge/Note-Important-red)

Please take note that we have extended the standard libraries by incorporating our custom code, which includes the implementation of the Tanh function and exponential function. These additions enhance the capabilities of the libraries and allow us to handle more complex mathematical operations within our project.
