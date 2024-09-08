import Foundation

class PrintHelper{
  static func printCoffeeShops(coffeeShops: [ECoffeeShop]) {
    for shop in coffeeShops {
      print("Coffee Shop: \(shop.name), Location: (\(shop.xCoordinate), \(shop.yCoordinate))")
    }
  }
  
  static func printClosestCoffeeShops(closestCoffeeShops: [EDistance]){
    for shop in closestCoffeeShops {
      print("\(shop.name),\(shop.distance.rounded(toPlaces: 4))")
    }
  }
}