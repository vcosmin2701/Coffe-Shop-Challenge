import Foundation

let coffeeShopService = CoffeeShopService()
let csvManager = CSVManager(argument: CommandLine.arguments[3])
let coordinateValidator = CoordinateValidatorImpl()
let mainApp = App(coffeeShopService: coffeeShopService, csvManager: csvManager, coordinateValidator: coordinateValidator)
mainApp.run(arguments: CommandLine.arguments)