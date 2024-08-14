import { readLines } from "./read"

const lines = readLines("example.txt")

const result = lines.reduce((acc, cur) => {
    const left = cur.split("").find((v) => /\d+/.test(v))!
    const right = cur.split("").reverse().find((v) => /\d+/.test(v))!
    const valueInLine = left + right;
    return acc + Number(valueInLine)
}, 0)

console.log({ result })

