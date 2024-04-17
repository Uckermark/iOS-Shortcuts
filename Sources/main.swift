import Foundation

@main
struct ShortcutsHelper {
    static func main() {
        if FileManager.default.fileExists(atPath: "/var/mobile/Library/Shortcuts/Shortcuts.sqlite") {
            do {
                let db = try DatabaseManager(withPath: "/var/mobile/Library/Shortcuts/Shortcuts.sqlite")
                let query = "SELECT ZNAME FROM ZSHORTCUT"
                let results = try db.executeQuery(query: query)

                // convert 2D array to 1D array (single column result)
                let convertedResult = results.compactMap { $0.first }

                // Convert the converted result to JSON
                let jsonData = try JSONSerialization.data(withJSONObject: convertedResult, options: [])
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString ?? "")
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("db not found")
        }
    }
}
