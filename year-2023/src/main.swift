import Foundation

guard let data = FileManager.default.contents(atPath: "example.txt") else {
    fatalError("Error reading file")
}
guard let fileContents = String(data: data, encoding: .utf8) else {
    fatalError("Error parsing content")
}
print("\(fileContents)")
