// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * @title DeployFactoryNFTContract
 * @author Shawn Rizo
 * @notice A script to deploy the FactoryNFTContract with configurations fetched from a HelperConfig contract.
 */
import { Script, console2 } from "forge-std/Script.sol";
import { HelperConfig } from "./HelperConfig.s.sol";
import { FactoryNFTContract } from "../src/FactoryNFTContract.sol";

contract DeployFactoryNFTContract is Script {
    HelperConfig helperConfig;

    /**
     * @dev Initializes the DeployFactoryNFTContract with the address of the HelperConfig contract.
     * @param helperConfigAddress The address of the HelperConfig contract.
     */
    constructor(address helperConfigAddress) {
        helperConfig = HelperConfig(helperConfigAddress);
    }

    /**
     * @notice Deploys the FactoryNFTContract with the active network configuration.
     * @dev Fetches the active network configuration from the HelperConfig contract and uses it to deploy the
     * FactoryNFTContract.
     * @return The address of the newly deployed FactoryNFTContract.
     */
    function run() external returns (FactoryNFTContract) {
        HelperConfig.NetworkConfig memory config = helperConfig.getActiveNetworkConfig();

        FactoryNFTContract factory = new FactoryNFTContract(config.initialOwner);

        return factory;
    }

    /**
     * @notice Returns the HelperConfig contract used by this script.
     * @return The HelperConfig contract.
     */
    function getHelperConfig() public view returns (HelperConfig) {
        return helperConfig;
    }
}
