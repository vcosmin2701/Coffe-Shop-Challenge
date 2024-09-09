import Foundation

class CSVManager {
    private let csvURL: String?
    private let csvFilePath: String?
    private let resourcesDir: String = "Resources"

    init(argument: String) {
        if argument.starts(with: "http") {
            self.csvURL = argument
            self.csvFilePath = nil
        } else {
            self.csvURL = nil
            self.csvFilePath = argument
        }
    }

    // if the user decides to use a local file, if exists will load coffee shops from it
    // if an URL is provided, will try to download the file from the URL, store it in the Resources folder and load it
    // the file will be overriden if it already exists
    
    func loadCoffeeShops() -> [ECoffeeShop] {
        if let csvFilePath = csvFilePath {
            let fileURL = URL(fileURLWithPath: resourcesDir).appendingPathComponent(csvFilePath)
            if FileManager.default.fileExists(atPath: fileURL.path) {
                print("Local file found: \(fileURL.path). Parsing the local file.")
                guard let csvData = try? String(contentsOfFile: fileURL.path, encoding: .utf8) else {
                    print("Failed to read local file.")
                    return []
                }
                return parseCSVData(csvData: csvData)
            } else {
                print("Local file not found at path: \(fileURL.path).")
                return []
            }
        } else if let csvURL = csvURL {
            print("Fetching data from the URL: \(csvURL).")
            guard let csvData = fetchCSV() else {
                print("Failed to fetch CSV data.")
                return []
            }
            let fileURL = URL(fileURLWithPath: resourcesDir).appendingPathComponent("coffee_shops.csv")
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

        // using the pipe to capture the output of the curl command
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
            try FileManager.default.createDirectory(atPath: resourcesDir, withIntermediateDirectories: true, attributes: nil)
            try csvData.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV data saved to file: \(fileURL.path).")
        } catch {
            print("Error saving CSV data to file: \(error)")
        }
    }

    private func parseCSVData(csvData: String) -> [ECoffeeShop] {
        var coffeeShops: [ECoffeeShop] = []
        let rows = csvData.split(separator: "\n")
        for row in rows {
            let columns = row.split(separator: ",")
            if columns.count == 3,
               let xCoordinate = Double(columns[1]),
               let yCoordinate = Double(columns[2]) {
                let coffeeShop = ECoffeeShop(name: String(columns[0]), xCoordinate: xCoordinate, yCoordinate: yCoordinate)
                coffeeShops.append(coffeeShop)
            }
        }
        return coffeeShops
    }
}