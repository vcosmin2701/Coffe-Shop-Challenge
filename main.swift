import Foundation

if CommandLine.arguments.count > 1 {
  let argument = CommandLine.arguments[3]
  
  guard let userXCoordinate = Double(CommandLine.arguments[1]),
  let userYCoordinate = Double(CommandLine.arguments[2]) else {
    print("Invalid user coordinates provided")
    exit(1)
  }

  let user = EUser(xCoordinate: userXCoordinate, yCoordinate: userYCoordinate)
  
  let manager = CSVManager(argument: argument)
  let coffeeShops = manager.loadCoffeeShops()

  let coffeeShopService = CoffeeShopService()

  let closestCoffeeShops = coffeeShopService.findClosestCoffeeShop(user: user, coffeeShops: coffeeShops)

  for shop in coffeeShops {
      print("Coffee Shop: \(shop.name), Location: (\(shop.xCoordinate), \(shop.yCoordinate))")
  }

  for shop in closestCoffeeShops {
    print("\(shop.name),\(shop.distance.rounded(toPlaces: 4))")
  }
}else{
  print("Please provide a valid URL or local file path.")
}

extension Double {
  func rounded(toPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}