import Foundation

let csvURL = "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv"

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
    print("CSV Data:\n\(csvString)")
  }else{
    print("Failed to load CSV data")
  }
} catch {
  print("Error running cURL command: \(error)")
}