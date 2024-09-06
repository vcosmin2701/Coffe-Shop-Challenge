import Foundation

class CSVManager {
    private let csvURL: String

    init(csvURL: String) {
        self.csvURL = csvURL
    }

    private func fetchCSV() -> String? {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/curl")
        process.arguments = ["-s", csvURL]

        let pipe = Pipe()
        process.standardOutput = pipe

        do {
            try process.run()
            process.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let csvString = String(data: data, encoding: .utf8) {
                return csvString
            } else {
                print("Failed to fetch CSV data")
                return nil
            }
        } catch {
            print("Error running cURL command: \(error)")
            return nil
        }
    }

    private func saveCSVToFile(csvData: String, fileName: String) {
        let resourcesDir = "Resources"
        let fileURL = URL(fileURLWithPath: resourcesDir).appendingPathComponent(fileName)

        do {
            try csvData.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV data saved to \(fileURL.path).")
        } catch {
            print("Error saving CSV data to file: \(error)")
        }
    }

    func getCSVData() {
        if let csvData = fetchCSV() {
            print("CSV data fetched successfully.")
            saveCSVToFile(csvData: csvData, fileName: "coffee_shops.csv")
        } else {
            print("Failed to fetch CSV data.")
        }
    }

    func parseCSVData(csvData: String) -> [ECoffeeShop] {
        var coffeeShops: [ECoffeeShop] = []
        let rows = csvData.components(separatedBy: "\n")

        for row in rows {
            let components = row.components(separatedBy: ",")
            if components.count == 3 {
                let name = components[0]
                if let xCoordinate = Double(components[1]), 
                   let yCoordinate = Double(components[2]) {
                    let coffeeShop = ECoffeeShop(name: name, xCoordinate: xCoordinate, yCoordinate: yCoordinate)
                    coffeeShops.append(coffeeShop)
                } else {
                    print("Invalid data format in CSV row: \(row)")
                }
            } else {
                print("Invalid data format in CSV fdsfdfrow: \(row)")
            }
        }
        return coffeeShops
    }
}

public struct ECoffeeShop {
  let name: String
  let xCoordinate: Double
  let yCoordinate: Double

  public init(name: String, xCoordinate: Double, yCoordinate: Double) {
      self.name = name
      self.xCoordinate = xCoordinate
      self.yCoordinate = yCoordinate
  }
}
