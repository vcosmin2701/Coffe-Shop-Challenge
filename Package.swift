// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "CoffeeShopChallenge",
    products: [
        .executable(name: "CoffeeShopChallenge", targets: ["CoffeeShopChallenge"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoffeeShopChallenge",
            dependencies: []
        ),
        .testTarget(
            name: "CoffeeShopChallengeTests",
            dependencies: ["CoffeeShopChallenge"]
        ),
    ]
)
