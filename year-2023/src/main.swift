import Foundation

let data = FileManager.default.contents(atPath: "sample2.txt")!
let fileContents = String(data: data, encoding: .utf8)!
let lines = fileContents.split(separator: "\n")

let digits = try Regex("[0-9]")

let response = try lines.map{ w in 
    let first = try digits.firstMatch(in: w)!
    let last = try digits.firstMatch(in: String(w.reversed()))!
    let val = Int("\(first.0)\(last.0)")!

    return val
 }.reduce(0) { (acc, el) in acc + el}

print(response)
