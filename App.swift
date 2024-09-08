import Foundation

class App {
  private let coffeeShopService: CoffeeShopService
  private let csvManager: CSVManager
  private let coordinateValidator: CoordinateValidatorImpl

  init(coffeeShopService: CoffeeShopService, csvManager: CSVManager, coordinateValidator: CoordinateValidatorImpl) {
      self.coffeeShopService = coffeeShopService
      self.csvManager = csvManager
      self.coordinateValidator = coordinateValidator
  }

  func run(arguments: [String]) {
      guard arguments.count == 4 else {
          print("Please provide user coordinates (X Y) and a valid file path.")
          exit(1)
      }

      guard let userXCoordinate = Double(arguments[1]),
          let userYCoordinate = Double(arguments[2]),
          coordinateValidator.isValid(x: userXCoordinate, y: userYCoordinate) else {
        print("Invalid coordinates. Please provide valid numbers for the user coordinates (X Y) within the range (-180 to 180 for X, -90 to 90 for Y).")
        exit(1)
    }

      let user = EUserFactory.createUser(xCoordinate: userXCoordinate, yCoordinate: userYCoordinate)
      let coffeeShops = csvManager.loadCoffeeShops()

      let closestCoffeeShops = coffeeShopService.findClosestCoffeeShop(user: user, coffeeShops: coffeeShops)

      PrintHelper.printClosestCoffeeShops(closestCoffeeShops: closestCoffeeShops)
  }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}