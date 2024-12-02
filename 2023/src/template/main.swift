import Foundation

let data = FileManager.default.contents(atPath: "example.txt")!
let fileContents = String(data: data, encoding: .utf8)!
print("\(fileContents)")
