if CommandLine.arguments.count > 1 {
  let argument = CommandLine.arguments[1]
  let manager = CSVManager(argument: argument)
  let coffeeShops = manager.loadCoffeeShops()

  for shop in coffeeShops {
      print("Coffee Shop: \(shop.name), Location: (\(shop.xCoordinate), \(shop.yCoordinate))")
  }
}else{
  print("Please provide a valid URL or local file path.")
}