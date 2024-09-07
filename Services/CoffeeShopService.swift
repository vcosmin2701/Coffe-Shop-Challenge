class CoffeeShopService {
  private let distanceCalculator = DistanceCalculator()

  func findClosestCoffeeShop(user: EUser, coffeeShops: [ECoffeeShop]) -> [EDistance]{
    let distances = coffeeShops.map {shop -> EDistance in
      let distance = distanceCalculator.calculateDistante(user: user, shop: shop)
      return EDistance(name: shop.name, distance: distance)
    }
    let sortedDistances = distances.sorted { $0.distance < $1.distance }
    return Array(sortedDistances.prefix(3))
  }
}