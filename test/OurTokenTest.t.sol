// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test{
    OurToken public ourToken;
    DeployOurToken public deployer;
    address public bob = makeAddr("bob");
    address public alice = makeAddr("alice");
    uint256 public constant STARTING_BALANCE = 1000 ether;
    
    //CHATGPT
    address public deployerAddress;
    uint256 public constant INITIAL_SUPPLY = 10000 ether;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    error ERC20InsufficientAllowance(address spender, uint256 currentAllowance,uint256 value);
    

    function setUp() public{
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        //CHATGPT
        deployerAddress = msg.sender;
        vm.prank(deployerAddress);
        ourToken.transfer(bob, STARTING_BALANCE);
        vm.stopPrank();
    }

    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), INITIAL_SUPPLY);
    }

    function testTransfer() public {
        uint256 transferAmount = 50 ether;

        vm.prank(bob);
        ourToken.transfer(alice, transferAmount);

        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
    }

    function testApprove() public {
        uint256 initialAllowance = 50 ether;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        assertEq(ourToken.allowance(bob, alice), initialAllowance);
    }


    function testBobBalance() public view{
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowancesWorks() public{
        uint256 initialAllowance = 1000 ether;
        uint256 transferAmount = 500 ether;
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice),transferAmount);
        assertEq(ourToken.balanceOf(bob),STARTING_BALANCE-transferAmount);

    }

    // function testIncreaseAllowance() public {
    //     uint256 initialAllowance = 50 ether;
    //     uint256 increaseAmount = 25 ether;

    //     vm.prank(bob);
    //     ourToken.approve(alice, initialAllowance);

    //     vm.prank(bob);
    //     ourToken.increaseAllowance(alice, increaseAmount);

    //     assertEq(ourToken.allowance(bob, alice), initialAllowance + increaseAmount);
    // }

    // function testDecreaseAllowance() public {
    //     uint256 initialAllowance = 50 ether;
    //     uint256 decreaseAmount = 25 ether;

    //     vm.prank(bob);
    //     ourToken.approve(alice, initialAllowance);

    //     vm.prank(bob);
    //     ourToken.decreaseAllowance(alice, decreaseAmount);

    //     assertEq(ourToken.allowance(bob, alice), initialAllowance - decreaseAmount);
    // }

    // function testTransferExceedsBalance() public {
    //     uint256 transferAmount = 200 ether;

    //     vm.prank(bob);
    //     vm.expectRevert("ERC20: transfer amount exceeds balance");
    //     ourToken.transfer(alice, transferAmount);
    // }

    // function testApproveAndTransferFromExceedsAllowance() public {
    //     uint256 initialAllowance = 50 ether;
    //     uint256 transferAmount = 75 ether;

    //     vm.prank(bob);
    //     ourToken.approve(alice, initialAllowance);

    //     vm.prank(alice);
    //     vm.expectRevert(
    //         abi.encodeWithSelector(
    //             ERC.ERC20InsufficientAllowance.Selector,
    //             bob,
    //             initialAllowance,
    //             transferAmount
    //         )
    //     );
    //     ourToken.transferFrom(bob, alice, transferAmount);
    // }

    function testEvents() public {
        uint256 transferAmount = 10 ether;

        vm.prank(bob);
        vm.expectEmit(true, true, true, true);
        emit Transfer(bob, alice, transferAmount);
        ourToken.transfer(alice, transferAmount);
    }

    // function testMint() public {
    //     uint256 mintAmount = 50 ether;

    //     vm.prank(deployerAddress);
    //     ourToken._mint(bob, mintAmount);

    //     assertEq(ourToken.balanceOf(bob), STARTING_BALANCE + mintAmount);
    //     assertEq(ourToken.totalSupply(), INITIAL_SUPPLY + mintAmount);
    // }

    // function testBurn() public {
    //     uint256 burnAmount = 50 ether;

    //     vm.prank(bob);
    //     ourToken.burn(burnAmount);

    //     assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - burnAmount);
    //     assertEq(ourToken.totalSupply(), INITIAL_SUPPLY - burnAmount);
    // }

    // function testBurnExceedsBalance() public {
    //     uint256 burnAmount = STARTING_BALANCE + 1 ether;

    //     vm.prank(bob);
    //     vm.expectRevert("ERC20: burn amount exceeds balance");
    //     ourToken.burn(burnAmount);
    // }

    


}