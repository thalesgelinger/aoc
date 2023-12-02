import Foundation

let data = FileManager.default.contents(atPath: "sample2.txt")!
let fileContents = String(data: data, encoding: .utf8)!
let lines = fileContents.split(separator: "\n")

let digits = try Regex("[0-9]")

let digitsMap = [
    "one": 1, 
    "two": 2, 
    "three": 3, 
    "four": 4, 
    "five": 5, 
    "six": 6, 
    "seven": 7, 
    "eight": 8, 
    "nine": 9
]


 let replacedLines = lines.map { l in
     var line = l
 
     digitsMap.forEach{ (key,value) in
        print(key, value)
        print("Line Antes: \(line)")
        line = l.replacingOccurrences(of: String(key), with: String(value))
        print("Line Depois: \(line)")
     }
 
     return line
 }
 
// let response = try replacedLines.map{ w in 
//     let first = try digits.firstMatch(in: w)!
//     let last = try digits.firstMatch(in: String(w.reversed()))!
//     let val = Int("\(first.0)\(last.0)")!
// 
//     return val
//  }.reduce(0) { (acc, el) in acc + el}

replacedLines.forEach {i in
    print(i)
}

