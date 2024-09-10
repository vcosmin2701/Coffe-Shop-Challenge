import XCTest
@testable import CoffeeShopChallenge

class AppTests: XCTestCase {
  func test_run_withValidInput_shouldNotExit() {
      // Arrange
      let coffeeShopService = CoffeeShopService()
      let csvManager = CSVManager(argument: "test_coffee_shops.csv")
      let coordinateValidator = CoordinateValidatorImpl()
      let app = App(coffeeShopService: coffeeShopService, csvManager: csvManager, coordinateValidator: coordinateValidator)

      // Act
      let validArguments = ["main", "10.0", "20.0", "test_coffee_shops.csv"]
      app.run(arguments: validArguments)

      // Assert
      XCTAssertTrue(true, "App should not exit with valid input.") 
  }
}