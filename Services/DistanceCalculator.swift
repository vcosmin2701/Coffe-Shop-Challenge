import Foundation

class DistanceCalculator {
  func calculateDistante(user: EUser, shop: ECoffeeShop) -> Double {
    let xDistance = shop.xCoordinate - user.xCoordinate
    let yDistance = shop.yCoordinate - user.yCoordinate
    return sqrt(pow(xDistance, 2) + pow(yDistance, 2))
  }
}