class DistanceCalculator {
  func calculateDistante(user: Coordinate, shop: Coordinate) -> Double {
    let xDistance = shop.xCoordinate - user.xCoordinate
    let yDistance = shop.yCoordinate - user.yCoordinate
    return sqrt(pow(xDistance, 2) + pow(yDistance, 2))
  }
}