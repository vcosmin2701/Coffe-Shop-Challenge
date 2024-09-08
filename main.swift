import Foundation

let coffeeShopService = CoffeeShopService()
let csvManager = CSVManager(argument: CommandLine.arguments[3])
let mainApp = App(coffeeShopService: coffeeShopService, csvManager: csvManager)
mainApp.run(arguments: CommandLine.arguments)