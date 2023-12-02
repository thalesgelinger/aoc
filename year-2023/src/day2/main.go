package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func main() {
	file, _ := os.ReadFile("input2.txt")
	content := string(file)
	lines := strings.Split(content, "\n")
	lines = lines[:len(lines)-1]

	semiCommaComma := regexp.MustCompile(`;|,`)

	response := 0

	for _, line := range lines {
		gameSplitted := strings.Split(line, ":")

		gameColorSet := semiCommaComma.Split(gameSplitted[1], -1)

		redMax, greenMax, blueMax := 0, 0, 0

		for _, gameColorSet := range gameColorSet {
			colorAndValue := strings.Split(gameColorSet, " ")
			// FIXME: i should not start with 1, missing trim
			valueAsString, color := colorAndValue[1], colorAndValue[2]
			value, _ := strconv.Atoi(valueAsString)

			switch color {
			case "red":
				if value > redMax {
					redMax = value
				}
				break
			case "blue":
				if value > blueMax {
					blueMax = value
				}
				break
			case "green":
				if value > greenMax {
					greenMax = value
				}
				break
			}
		}
		valueSetted := redMax * blueMax * greenMax
		response += valueSetted
	}

	fmt.Println("Response: ", response)
}
