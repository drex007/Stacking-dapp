const hre = require("hardhat")

async function main() {
    console.log("veryfing ============================?");
    await hre.run("verify:verify", {
        address: "0x0651FEb93bF4A84BC03E44bD1888Ca9d1B53bC5C",
        // constructorArguments: [name, symbol, _metadataUri, _maxTokens],
    })
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })