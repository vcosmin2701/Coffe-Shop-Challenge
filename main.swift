import Foundation

if CommandLine.arguments.count == 4 {
  print("Arguments: \(CommandLine.arguments)") // Add this line for debugging
  if let userXCoordinate = Double(CommandLine.arguments[1]),
     let userYCoordinate = Double(CommandLine.arguments[2]) {

      let filePath = CommandLine.arguments[3]
      let user = EUser(xCoordinate: userXCoordinate, yCoordinate: userYCoordinate)
      let manager = CSVManager(argument: filePath)
      let coffeeShops = manager.loadCoffeeShops()

      let coffeeShopService = CoffeeShopService()

      let closestCoffeeShops = coffeeShopService.findClosestCoffeeShop(user: user, coffeeShops: coffeeShops)

      for shop in coffeeShops {
          print("Coffee Shop: \(shop.name), Location: (\(shop.xCoordinate), \(shop.yCoordinate))")
      }

      for shop in closestCoffeeShops {
          print("\(shop.name),\(shop.distance.rounded(toPlaces: 4))")
      }
  } else {
      print("Invalid coordinates. Please provide valid numbers for the user coordinates (X Y).")
      exit(1)
  }
} else {
  print("Please provide user coordinates (X Y) and a valid file path.")
  exit(1)
}

extension Double {
  func rounded(toPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}