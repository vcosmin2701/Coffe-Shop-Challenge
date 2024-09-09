import Foundation

// Decided to used dependency-injection instead of 
// having the main logic of the entire program in the main.swift
// it's much cleaner and provide better isolation

let coffeeShopService = CoffeeShopService()
let csvManager = CSVManager(argument: CommandLine.arguments[3])
let coordinateValidator = CoordinateValidatorImpl()
let mainApp = App(coffeeShopService: coffeeShopService, csvManager: csvManager, coordinateValidator: coordinateValidator)
mainApp.run(arguments: CommandLine.arguments)