import Foundation

class CSVManager {
    private let csvURL: String?
    private let localFileName: String = "coffee_shops.csv"
    private let resourcesDir: String = "Resources"

    init(argument: String) {
        if argument.starts(with: "http") {
            self.csvURL = argument
        } else {
            self.csvURL = nil
        }
    }

    func loadCoffeeShops() -> [ECoffeeShop] {
        let fileURL = URL(fileURLWithPath: resourcesDir).appendingPathComponent(localFileName)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("Local file found: \(fileURL.path). Parsing the local file.")
            guard let csvData = try? String(contentsOfFile: fileURL.path, encoding: .utf8) else {
                print("Failed to read local file.")
                return []
            }
            return parseCSVData(csvData: csvData)
        } else if let csvURL = csvURL {
            print("Fetching data from the URL: \(csvURL).")
            guard let csvData = fetchCSV() else {
                print("Failed to fetch CSV data.")
                return []
            }
            saveCSVToFile(csvData: csvData, fileURL: fileURL)
            return parseCSVData(csvData: csvData)
        } else {
            print("No valid file path or URL provided.")
            return []
        }
    }

    private func fetchCSV() -> String? {
        guard let csvURL = csvURL else { return nil }
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
                print("Failed to fetch CSV data.")
                return nil
            }
        } catch {
            print("Error running cURL command: \(error)")
            return nil
        }
    }

    private func saveCSVToFile(csvData: String, fileURL: URL) {
        do {
            let directoryURL = URL(fileURLWithPath: resourcesDir)
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            }

            try csvData.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV data saved to \(fileURL.path).")
        } catch {
            print("Error saving CSV data to file: \(error)")
        }
    }

    private func parseCSVData(csvData: String) -> [ECoffeeShop] {
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