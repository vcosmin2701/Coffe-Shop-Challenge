import Foundation

class CSVManager {
    private let csvURL: String

    init(csvURL: String) {
        self.csvURL = csvURL
    }

    func fetchCSV() -> String? {
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

    func saveCSVToFile(csvData: String, fileName: String) {
        let resourcesDir = "Resources"
        let fileURL = URL(fileURLWithPath: resourcesDir).appendingPathComponent(fileName)

        do {
            try csvData.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV data saved to \(fileURL.path).")
        } catch {
            print("Error saving CSV data to file: \(error)")
        }
    }


    func parseCSVData(csvData: String) -> [ECoffeeShop] {
        var coffeeShops: [ECoffeeShop] = []

        let rows = csvData.split(separator: "\n")
        
        for row in rows {
            let components = row.split(separator: ",")

            guard components.count == 3 else {
                print("Invalid row format: \(row)")
                continue
            }

            let name = String(components[0])
            
            guard let xCoordinate = Double(components[1]), let yCoordinate = Double(components[2]) else {
                print("Invalid coordinates in row: \(row)")
                continue
            }
            
            let coffeeShop = ECoffeeShop(name: name, xCoordinate: xCoordinate, yCoordinate: yCoordinate)
            coffeeShops.append(coffeeShop)
        }

        return coffeeShops
    }
}


