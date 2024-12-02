import Foundation

let data = FileManager.default.contents(atPath: "input2.txt")!
let fileContents = String(data: data, encoding: .utf8)!
let lines = fileContents.split(separator: "\n")

var totalTime = Int(lines[0].split(separator: " ")[1...].joined())!
var currentMaxDistance = Int(lines[1].split(separator: " ")[1...].joined())!

var minHoldintTime = -1
var maxHoldintTime = -1
for holdingTime in 1...totalTime {
    let distanceForMinHolding = (totalTime - holdingTime) * holdingTime
    if (distanceForMinHolding > currentMaxDistance && minHoldintTime < 0){
        minHoldintTime = holdingTime
    }
    let testeMaxHolding = totalTime - holdingTime;
    let distanceForMaxHolding = (totalTime - testeMaxHolding) * testeMaxHolding
    if (distanceForMaxHolding > currentMaxDistance && maxHoldintTime < 0){
        maxHoldintTime = testeMaxHolding
    }

    if (minHoldintTime > 0 && maxHoldintTime > 0) {
        break
    }
}


let result = maxHoldintTime - minHoldintTime + 1

print(result)
