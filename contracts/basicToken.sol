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

/*** This token will implement ERC20 standard. **/
import './erc20.sol';


contract BasicToken is ERC20 {
    // The public variable of the token that will hold the total supply.
    uint256 public totalSupply;

    // Name of the token, eg: "Basic Token"
    string public name;

    // Symbol of the token, eg: "BTK"
    string public symbol;

    // Number of decimals that the token uses, eg: 8
    uint8 public decimals;

    // This mapping will hold the balances of all the addresses that have the token.
    mapping (address => uint256) public balanceOf;
    // This mapping will hold the balance of the addresses that are allowed to spend tokens in behalf of the owner.
    mapping (address => mapping (address => uint256)) public allowanced;

    /***** OPTIONAL FUNCTIONS *****/
    function name() public constant returns (string) {
        return name;
    }

    function symbol() public constant returns (string) {
        return symbol;
    }

    function decimals() public constant returns (uint8) {
        return decimals;
    }

    /**
     * Total supply of the token
     *
     * Get the total supply of the token.
     */
    function totalSupply() public constant returns (uint256 supply) {
        return totalSupply;
    }

    /**
     * Token balance of _owner
     *
     * Get the balance of _owner.
     */
    function balanceOf(address _owner) public constant returns (uint256) {
        return balanceOf[_owner];
    }

    /**
     * Internal transfer, only called by the contract.
     */
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != 0x0);                                    // Prevent transfer to 0x0 address.
        require(balanceOf[_from] >= _value);                    // Check if sender has enough balance.
        require(balanceOf[_to] + _value > balanceOf[_to]);      // Check for overflows.

        // Save this for an assertion in the future.
        uint previousBalances = balanceOf[_from] + balanceOf[_to];

        // Make the transfer and fire the event.
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);

        // Asserts are used to use static analysis to find bugs in the code. They never should fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }
 
    /**
     * Transfer tokens
     *
     * Send '_value' tokens to '_to' address.
     *
     * @param _to The address of the recipient.
     * @param _value The amount of tokens that are being transfered.
     */
    function transfer(address _to, uint256 _value) public returns (bool) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * Transfer tokens in behalf of another address
     *
     * Send '_value' tokens to '_to' address in behalf of '_from'.
     *
     * @param _from The address of the sender.
     * @param _to The address of the recipient.
     * @param _value The amount of tokens that are being transfered.
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(allowanced[_from][msg.sender] >= _value);       // Check allowanced amount.

        // Substract the amount sended from the allowanced amount.
        allowanced[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    /**
     * Set allowanced for other address
     *
     * Allows `_spender` to spend no more than `_value` tokens in your behalf
     *
     * @param _spender The address authorized to spend
     * @param _value The max amount they can spend
     */
    function approve(address _spender, uint256 _value) public returns (bool) {
        // Save that _spender can use _value amount to spend in your behalf.
        allowanced[msg.sender][_spender] = _value;

        // Emit event.
        Approval(msg.sender, _spender, _value);

        return true;
    }

    /**
     * Get the remaining balance of allowanced tokens of _owner that _spender can spend.
     */
    function allowance(address _owner, address _spender) public constant returns (uint256) {
        return allowanced[_owner][_spender];
    }


    /*** FOR DEPLOYMENT OF THE TOKEN ***/
    // If any ether is sent to this contract, it will be returned, also all the remaining gas.
    function () {
        revert();
    }

    function BasicToken() {
        balanceOf[msg.sender] = 1000;
        totalSupply = 1000;
        name = "BasicToken";
        symbol = "BST";
        decimals = 8;
    }
}