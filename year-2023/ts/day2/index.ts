
import { readLines } from "../read"

const lines = readLines("day2/input.txt")

type Bag = {
    red: number
    green: number
    blue: number
}

export const part1 = () => {
    const elfBag: Bag = {
        red: 12,
        green: 13,
        blue: 14
    }

    const parseBagItems = (itemsLine: string): Partial<Bag> => {
        return itemsLine.split(",")
            .map(v => v.trim().split(" "))
            .reduce((acc, cur) => ({ ...acc, [cur[1]]: +cur[0] }), {})
    }

    const result = lines.map((line,) => {
        const [game, items] = line.split(":")
        const id = +game.split(" ")[1].trim()
        const bagsInGame = items.split(";").map(bagStr => parseBagItems(bagStr))

        const isCapable = Object.entries(elfBag).every(([color, value]) => bagsInGame.every(bag => (bag[color] ?? 0) <= value))

        if (isCapable) {
            return id
        }
        return 0
    }).reduce((acc, i) => acc + i, 0)

    console.log({ result })
}

export const part2 = () => { }
