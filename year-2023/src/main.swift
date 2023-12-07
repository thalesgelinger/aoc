import Foundation

let data = FileManager.default.contents(atPath: "input.txt")!
let fileContents = String(data: data, encoding: .utf8)!
let lines = fileContents.split(separator: "\n")

var times = lines[0].split(separator: " ")[1...]
var distances = lines[1].split(separator: " ")[1...]

var result = 1

while times.count > 0 {
    let totalTime = Int(times.popFirst()!)!
    let currentMaxDistance = Int(distances.popFirst()!)!

    var countedWaysToWin = 0
    for holdingTime in 1...totalTime {
        let distance = (totalTime - holdingTime) * holdingTime
        if (distance > currentMaxDistance){
            countedWaysToWin += 1
        }
    }

    result *= countedWaysToWin

}

print(result)
