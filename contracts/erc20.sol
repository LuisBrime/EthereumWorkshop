/**
 *  Copyright 2018 Luis Brime
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
pragma solidity ^0.4.16;

// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// Interface for ERC 20 Token standard
contract ERC20 {

    /***** OPTIONAL FUNCTIONS *****/
    // Returns the name of the token.
    function name() public constant returns (string);

    // Returns the symbol of the token.
    function symbol() public constant returns (string);

    // Returns the number of decimals the token uses.
    function decimals() public constant returns (uint8);

    /***** REQUIRED FUNCTIONS *****/
    // Returns the total number of tokens that were created: total supply.
    function totalSupply() public constant returns (uint256);

    // Returns the token balance of a given address.
    function balanceOf(address _owner) public constant returns (uint256);

    // Transfers a number of tokens _value to an address _to from the address that called the function.
    // If the address does not have enough balance, it should throw the function.
    // If the _value is 0, the function and the event still need to happen.
    function transfer(address _to, uint256 _value) public returns (bool);

    // Transfers a number of tokens _value to an address _to from the addres _from.
    // This works only if the caller has been authorized by _from to transfer tokens in its behalf.
    // If the _value is 0, the function and the event still need to happen.
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);

    // Allows _spender to transfer a number of tokens _value in yuor behalf.
    // If the function is called again with another _value, it overrides the current allowance.
    function approve(address _spender, uint256 _value) public returns (bool);

    // Returns the amount of tokens that the _spender is still allowed to transfer in behalf of _owner.
    function allowance(address _owner, address _spender) public constant returns (uint256);

    /***** EVENTS *****/
    // Triggers when tokens are transfered, even when _value = 0.
    // Token contract which creates tokens should trigger the event.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Triggers on any succesfull call to approve(address _spender, uint256 _value).
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); 

}