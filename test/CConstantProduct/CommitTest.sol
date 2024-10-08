// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;

import {CConstantProductTestHarness, CConstantProduct} from "./CConstantProductTestHarness.sol";

abstract contract CommitTest is CConstantProductTestHarness {
    function testSolutionSettlerCanSetAnyCommit() public {
        vm.prank(address(solutionSettler));
        constantProduct.commit(0x4242424242424242424242424242424242424242424242424242424242424242);
    }

    function testCommitIsPermissioned() public {
        vm.prank(makeAddr("some random address"));
        vm.expectRevert(abi.encodeWithSelector(CConstantProduct.CommitOutsideOfSettlement.selector));
        constantProduct.commit(0x4242424242424242424242424242424242424242424242424242424242424242);
    }

    function testCommittingSetsCommitment() public {
        bytes32 commitment = 0x4242424242424242424242424242424242424242424242424242424242424242;
        assertEq(constantProduct.commitment(), bytes32(0));
        vm.prank(address(solutionSettler));
        constantProduct.commit(commitment);
        assertEq(constantProduct.commitment(), commitment);
    }
}
