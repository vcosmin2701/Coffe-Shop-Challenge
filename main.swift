let csvURL = "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv"
let csvManager = CSVManager(csvURL: csvURL)

if let csvData = csvManager.fetchCSV() {
  print("CSV data fetched successfully.")
  csvManager.saveCSVToFile(csvData: csvData, fileName: "coffee_shops.csv")
  
  let coffeeShops = csvManager.parseCSVData(csvData: csvData)
  for coffeeShop in coffeeShops {
    print(coffeeShop, separator: "\n")
  }
} else {
  print("Failed to fetch CSV data.")
}

