import * as day1 from "./day1"
console.log(process.argv[2])

switch (Number(process.argv[2])) {
    case 1:
        console.log("PART 1")
        day1.part1()
        console.log("PART 2")
        day1.part2()
        break
    default:
        console.log("Missing day number")
}

