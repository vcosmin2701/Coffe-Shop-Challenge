let csvURL = "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv"
let csvManager = CSVManager(csvURL: csvURL)

csvManager.getCSVData()

let coffeeShops = csvManager.parseCSVData(csvData: "Resources/coffe_shops.csv")
print(coffeeShops)