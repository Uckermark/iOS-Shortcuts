import Foundation
import SQLite3

class DatabaseManager {
    var db: OpaquePointer?

    init(withPath path: String) throws {
        if sqlite3_open(path, &db) != SQLITE_OK {
            throw NSError(domain: "DatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error opening database"])
        }
    }

    deinit {
        sqlite3_close(db)
    }

    func executeQuery(query: String) throws -> [[Any]] {
        var resultArray = [[Any]]()
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                var row = [Any]()
                let columns = sqlite3_column_count(statement)
                for i in 0..<columns {
                    let type = sqlite3_column_type(statement, i)
                    switch type {
                    case SQLITE_INTEGER:
                        row.append(Int(sqlite3_column_int(statement, i)))
                    case SQLITE_FLOAT:
                        row.append(Double(sqlite3_column_double(statement, i)))
                    case SQLITE_TEXT:
                        if let text = sqlite3_column_text(statement, i) {
                            row.append(String(cString: text))
                        }
                    case SQLITE_BLOB:
                        if let blob = sqlite3_column_blob(statement, i) {
                            let blobLength = Int(sqlite3_column_bytes(statement, i))
                            row.append(Data(bytes: blob, count: blobLength))
                        }
                    default:
                        continue
                    }
                }
                resultArray.append(row)
            }
        } else {
            throw NSError(domain: "DatabaseManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error executing query"])
        }
        sqlite3_finalize(statement)
        return resultArray
    }
}