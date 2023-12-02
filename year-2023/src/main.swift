import Foundation

let data = FileManager.default.contents(atPath: "input2.txt")!
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

let response = try lines.map { l in
    var line = String(l)
    var head = "";
    var tail = "";
    var left = "";
    var right = "";

    for (i, le) in l.enumerated() {
        if (left == ""){
            head += String(le)

            if le.isNumber {
                left = String(le)
            }

            for (d, v) in digitsMap {
                if head.contains(d) {
                    left = String(v)
                }
            }
        }
        if (right == "") {
            tail = String(l.suffix(i+1))

            if tail.first!.isNumber {
                right = String(tail.first!)
            }

            for (d, v) in digitsMap {
                if tail.contains(d) {
                    right = String(v)
                    break
                }
            }
        }

        if( right != "" && left != "") {
            break;
        }


    }

    return Int("\(left)\(right)")!
}.reduce(0) { (acc, el) in acc + el}



print(response)

