
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

export const part2 = () => {
    const parseBagItems = (itemsLine: string): Partial<Bag> => {
        return itemsLine.split(",")
            .map(v => v.trim().split(" "))
            .reduce((acc, cur) => ({ ...acc, [cur[1]]: +cur[0] }), {})
    }

    const result = lines.map((line,) => {
        const [, items] = line.split(":")
        const bagsInGame = items.split(";").map(bagStr => parseBagItems(bagStr))
        const amount = bagsInGame.reduce<Bag>((acc, cur) => {
            const red = cur?.red ?? 0
            const blue = cur?.blue ?? 0
            const green = cur?.green ?? 0

            red > acc.red && (acc.red = red)
            blue > acc.blue && (acc.blue = blue)
            green > acc.green && (acc.green = green)

            return acc
        }, {
            red: 0,
            blue: 0,
            green: 0,
        })
        return amount.red * amount.blue * amount.green

    }).reduce((acc, i) => acc + i, 0)

    console.log({ result })

}
