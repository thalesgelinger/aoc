import { readLines } from "../read"

const lines = readLines("day1/input.txt")

export const part1 = () => {
    let result = 0;

    for (let line of lines) {
        const chars = line.split("")
        let right = 0;
        let left = 0
        for (let i = 0; i < chars.length; i++) {
            if (!left && /\d+/.test(chars[i])) {
                left = Number(chars[i])
            }
            if (!right && /\d+/.test(chars[chars.length - i - 1])) {
                right = Number(chars[chars.length - i - 1])
            }
            if (left && right) break
        }
        result += left * 10 + right
    }

    console.log({ result })
}

export const part2 = () => {

    const numAsWords = {
        one: 1,
        two: 2,
        three: 3,
        four: 4,
        five: 5,
        six: 6,
        seven: 7,
        eight: 8,
        nine: 9
    }

    console.log({ lines })

    let result = 0;

    for (let line of lines) {
        const chars = line.split("")
        let right = 0;
        let left = 0
        for (let i = 0; i < chars.length; i++) {
            if (!left) {
                if (/\d+/.test(chars[i])) {
                    left = Number(chars[i])
                } else {
                    const leftPart = chars.slice(0, i + 1).join("")
                    const matched = Object.keys(numAsWords)
                        .find((w) => leftPart.includes(w)
                        )
                    if (matched) {
                        left = numAsWords[matched]
                    }
                }
            }
            if (!right) {
                if (/\d+/.test(chars[chars.length - i - 1])) {
                    right = Number(chars[chars.length - i - 1])
                } else {
                    const rightPart = chars
                        .slice(chars.length - 1 - i, chars.length).join("")
                    const matched = Object.keys(numAsWords)
                        .find((w) => rightPart.includes(w)
                        )
                    if (matched) {
                        right = numAsWords[matched]
                    }
                }
            }
            if (left && right) break
        }
        result += left * 10 + right
    }

    console.log({ result })
}
